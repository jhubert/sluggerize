module Sluggerize
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
