module Sluggerize
  def self.included(base)
    base.extend ClassMethods
  end
  module ClassMethods
    def sluggerize(attr=nil,options={})
      class_inheritable_accessor :options
      attr ||= :title
      options[:as_param] ||= true
      options[:substitution_char] ||= '-'
      self.options = options

      raise ArgumentError, "#{self.name} is missing source column" if columns_hash[attr.to_s].nil?
      raise ArgumentError, "#{self.name} is missing required slug column" if columns_hash['slug'].nil?

      before_validation :create_slug, :on => :create

      validates_presence_of :slug
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
  module InstanceMethods

    def to_param
      options[:as_param] ? self.slug : self.id
    end

    protected

    def create_slug
      self.slug ||= clean("#{column_to_slug}")
    end
  
    def clean(string)
      string.downcase.gsub(/[^\w\s\d\_\-]/,'').gsub(/\s\s+/,' ').gsub(/[^\w\d]/, options[:substitution_char])
    end
  end
end

ActiveRecord::Base.send(:include, Sluggerize)