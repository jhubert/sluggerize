module Sluggerize
  class NoSlugColumnError < StandardError
    def to_s
      'There must be a slug column defined in the database table for this model'
    end
  end
  class NoSourceColumnError < StandardError
    def to_s
      'The column matching the attribute you want to sluggerize can not be found in the database table'
    end
  end
end
