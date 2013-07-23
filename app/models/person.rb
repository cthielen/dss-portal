class Person < ActiveResource::Base
	self.site = $DSS_RM_SETTINGS['API_KEY_HOST']
	self.user = $DSS_RM_SETTINGS['API_KEY_USER']
	self.password = $DSS_RM_SETTINGS['API_KEY_PASSWORD']
	self.element_name = "person"
end

#class Person < ActiveRecord::Base
#  has_many :rm_application_assignments
#  has_many :bookmark_assignments
#  has_many :applications
#  accepts_nested_attributes_for :applications
#  attr_accessible :loginid, :name
#end
