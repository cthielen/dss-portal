class RmPerson < ActiveResource::Base
  self.site = $DSS_RM_SETTINGS['API_KEY_HOST']
  self.user = $DSS_RM_SETTINGS['API_KEY_USER']
  self.password = $DSS_RM_SETTINGS['API_KEY_PASSWORD']
  self.element_name = "person"

  def accessible_applications
    apps = []
    filtered_roles = role_assignments.uniq{ |a| a.application_id }
    filtered_roles.each do |roles|
      apps << roles
    end
    apps
  end
end

