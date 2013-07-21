class RmPerson < ActiveResource::Base
	self.site = $DSS_RM_SETTINGS['API_KEY_HOST']
	self.user = $DSS_RM_SETTINGS['API_KEY_USER']
	self.password = $DSS_RM_SETTINGS['API_KEY_PASSWORD']
	self.element_name = "person"  --rename this to 
end
