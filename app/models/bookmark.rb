class Bookmark < ActiveRecord::Base
  has_many :bookmark_assignments
  attr_accessible :description, :name, :url
end
