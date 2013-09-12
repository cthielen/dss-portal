class ApplicationController < ActionController::Base
  before_filter CASClient::Frameworks::Rails::Filter
  before_filter :set_current_user
  before_filter :find_or_create_person
  before_filter :update_rm_assignments
  protect_from_forgery
  
  def logout
    logger.info "#{session[:cas_user]}@#{request.remote_ip}: Logged out."
    CASClient::Frameworks::Rails::Filter.logout(self)
  end
  
  def set_current_user
    Authorization.current_user = @current_user = RmPerson.find(session[:cas_user])
    
    logger.info "#{session[:cas_user]}@#{request.remote_ip}: Set current user to #{Authorization.current_user.inspect}."
  end
  
  def find_or_create_person
    @person = Person.includes(:application_assignments).find_or_create_by_loginid(session[:cas_user])
    @rm_person = @current_user
  end

  # OPTIMIZE ME - this function will blindly create/delete in rapid succession, activerecord writes could be eliminated with better logic
  # Check for recent application permission additions/changes/revocations on roles management for the logged in user.
  def update_rm_assignments
    # Obtain RM applications assigned to user
    @rm_apps = @rm_person.accessible_applications
    
    # Ensure application_assignments matches @rm_apps for apps which come from RM.
    # Note that some apps (bookmarks) do not come from RM and further, some RM apps
    # may have portal-side data (i.e. 'favorited').
    @rm_apps.each do |app|
      # Look up the local app data for this RM app (we cache certain attributes)
      app_attribute = RmApplicationAttribute.find_or_initialize_by_rm_application_id(app[:id])
      
      # Look up the local app_assignment that represents this RM app/person duple
      app_assignment = @person.application_assignments.find_or_create_by_rm_application_attribute_id(app_attribute.id)
      
      if app_attribute.new_record? or app_attribute.updated_at < 72.hours.ago
        # Cache RM application data into app_attribute
        app_attribute_data = RmApplication.find(app[:id])
        
        app_attribute.name = app_attribute_data.name
        app_attribute.description = app_attribute_data.description
        app_attribute.url = app_attribute_data.url
        if app_attribute_data.icon and app_attribute_data.icon.length > 0
          app_attribute.icon_path = "https://roles.dss.ucdavis.edu/" + app_attribute_data.icon
        else
          app_attribute.icon_path = "/assets/#{app_attribute.name[0].downcase}.jpg"
        end
        
        app_attribute.save!
      end

      app_assignment.rm_application_attribute = app_attribute
      
      app_assignment.save!
    end

    # Check for permission revocation 
    # Go through @person.application_assignments and remove any non-bookmark ones which are not in @rm_apps
    @person.application_assignments.keep_if do |assignment|
      assignment.bookmark or @rm_apps.find_index{ |r| r[:id] == assignment.rm_application_attribute.rm_application_id }
    end
    
    @person.save!
  end
end
