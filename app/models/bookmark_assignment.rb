class BookmarkAssignment < ActiveRecord::Base
  has_one :application, :as => :category
  attr_accessible :bookmark_id, :loginid

end
