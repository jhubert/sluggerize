require 'active_record'
require 'sluggerize/errors'
require 'sluggerize/class_methods'
require 'sluggerize/instance_methods'

module Sluggerize
  def self.included(base)
    base.extend ClassMethods
  end
end

ActiveRecord::Base.send(:include, Sluggerize)