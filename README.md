# Sluggerize

A simple plugin that automatically generates a slug for a model on create. It takes care of protecting the key, automatically generating it and making sure it is unique.

## Usage

    sluggerize :source_column, [options]

### Source Column

If you don't provide a source column, it will default to looking for a "title" column.

### Options

* **as_params** [*False*] If true, this will be used as the id of the object when creating URLs and you will be able to Object.find(slug)
* **substitution_char** - [-] The character to use when replacing spaces and other unsupported characters

## Example

    create_table "projects" do |t|
      t.string   "title"
      t.string   "slug"
    end

    class Project < ActiveRecord::Base
      sluggerize
    end

    Project.create(:title => 'A Very Happy Project')
    Project.first.slug
    => 'a-very-happy-project'

Copyright (c) 2011 Jeremy Hubert, released under the MIT license
