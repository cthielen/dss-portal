class BookmarkAssignment < ActiveRecord::Base
  has_one :application, :as => :category
  belongs_to :person
  belongs_to :bookmark
  attr_accessible :bookmark_id, :loginid

end
