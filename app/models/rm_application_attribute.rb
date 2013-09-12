class RmApplicationAttribute < ActiveRecord::Base
  attr_accessible :description, :name, :url, :rm_application_id
  validates :rm_application_id, presence: true
end
