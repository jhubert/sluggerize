require 'test/test_helper'

class SluggerizeBaseTest < ActiveSupport::TestCase
end

class SluggerizeTest < SluggerizeBaseTest
  test "should generate slug on create" do
    ObjectWithTitleAndSlug.sluggerize

    assert_difference('ObjectWithTitleAndSlug.count') do
      o = ObjectWithTitleAndSlug.create(:title => 'hello')
      assert_not_nil o.slug
    end
  end

  test "should be invalid with a blank slug" do
    ObjectWithTitleAndSlug.sluggerize

    assert_no_difference('ObjectWithTitleAndSlug.count') do
      o = ObjectWithTitleAndSlug.create
    end
  end

  test "should format the source for a slug" do
    ObjectWithTitleAndSlug.sluggerize

    o = ObjectWithTitleAndSlug.create(:title => 'Jeremy Was Here')
    assert_equal 'jeremy-was-here', o.slug
  end

  test "should remove all non url friendly characters" do
    ObjectWithTitleAndSlug.sluggerize

    o = ObjectWithTitleAndSlug.create(:title => 'a!@#$%^&*()_+a')
    assert_equal 'a_a', o.slug
  end

  test "should replace all spaces with the substitution char" do
    ObjectWithTitleAndSlug.sluggerize

    o = ObjectWithTitleAndSlug.create(:title => 'a a')
    assert_equal 'a-a', o.slug
  end

  test "should set defaults if no options are passed in" do
    ObjectWithTitleAndSlug.sluggerize

    assert_not_nil ObjectWithTitleAndSlug.options[:substitution_char]
    assert_not_nil ObjectWithTitleAndSlug.options[:as_param]
  end

  test "should default to as_params true" do
    ObjectWithTitleAndSlug.sluggerize

    assert ObjectWithTitleAndSlug.options[:as_param]
  end

  test "should set as_params to true if anything other than false is passed in to parameters" do
    ObjectWithTitleAndSlug.sluggerize(nil, :as_param => 'test')

    assert ObjectWithTitleAndSlug.options[:as_param]
  end

  test "should set as_params to false via parameters" do
    ObjectWithTitleAndSlug.sluggerize(nil, :as_param => false)

    assert !ObjectWithTitleAndSlug.options[:as_param]
  end

  test "should raise an error if the substitution char is not a string" do
    assert_raise ArgumentError do
      ObjectWithTitleAndSlug.sluggerize(nil, :substitution_char => Object)
    end
  end

  test "should raise an error if the source column does not exist" do
    assert_raise Sluggerize::NoSourceColumnError do
      ObjectWithNonTitleColumnAndSlug.sluggerize
    end
  end

  test "should raise an error if the slug column does not exist" do
    assert_raise Sluggerize::NoSlugColumnError do
      ObjectWithoutSlug.sluggerize
    end
  end

end