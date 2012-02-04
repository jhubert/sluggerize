require 'rubygems'
require 'test/unit'
require 'active_support'
require 'active_record'
require 'active_model'

$:.unshift "#{File.dirname(__FILE__)}/../"
$:.unshift "#{File.dirname(__FILE__)}/../lib/"

require 'sluggerize'

ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")

ActiveRecord::Schema.define(:version => 1) do
  create_table :objects_with_title_and_slug do |t|
    t.string    :title
    t.string    :slug
  end

  create_table :objects_with_non_title_column_and_slug do |t|
    t.string    :name
    t.boolean   :slug
  end

  create_table :objects_without_slug do |t|
    t.string    :title
  end
end

class ObjectWithTitleAndSlug < ActiveRecord::Base
  self.table_name = 'objects_with_title_and_slug'
end

class ObjectWithNonTitleColumnAndSlug < ActiveRecord::Base
  self.table_name = 'objects_with_non_title_column_and_slug'
end

class ObjectWithoutSlug < ActiveRecord::Base
  self.table_name = 'objects_without_slug'
end
