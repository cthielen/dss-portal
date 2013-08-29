class RmApplicationAttribute < ActiveRecord::Base
  attr_accessible :description, :name, :url, :image, :rm_application_id
  has_attached_file :image
  validates :rm_application_id, presence: true
end
