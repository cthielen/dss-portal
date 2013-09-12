class RmApplicationAttribute < ActiveRecord::Base
  validates_presence_of :rm_application_id

  attr_accessible :description, :name, :url, :rm_application_id
end
