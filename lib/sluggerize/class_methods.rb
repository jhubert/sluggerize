module Sluggerize
  module ClassMethods
    def sluggerize(attr=nil, options={})
      class_attribute :options

      attr ||= :title
      options[:as_param] = true unless options[:as_param] == false
      options[:substitution_char] ||= '-'
      self.options = options

      raise ArgumentError unless options[:substitution_char].is_a?(String)

      if ActiveRecord::Base.connection.table_exists?(self.table_name)
        raise NoSourceColumnError, "#{self.name} is missing source column" if columns_hash[attr.to_s].nil?
        raise NoSlugColumnError, "#{self.name} is missing required slug column" if columns_hash['slug'].nil?
      end

      before_validation :create_slug, :on => :create

      validates_presence_of :slug, :allow_nil => (options[:as_param] ? true : false)
      validates_uniqueness_of :slug, :allow_nil => (options[:as_param] ? true : false)

      send :define_method, :column_to_slug, lambda { self.send(attr) }

      class << self
        def find(*args)
          if self.options[:as_param] && args.first.is_a?(String)
            find_by_slug(args)
          else
            super(*args)
          end
        end
      end
    
      include InstanceMethods
    end
  end
end