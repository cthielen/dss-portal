class ApplicationController < ActionController::Base
  before_filter CASClient::Frameworks::Rails::Filter
  before_filter :set_current_user
  before_filter :find_or_create_person
  before_filter :update_rm_assignments
  protect_from_forgery
  
  def welcome
    if session[:cas_user]
      redirect_to :controller => 'application_assignments', :action => 'index'
    end
  end
  
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


  # OPTIMIZE ME - this function will blindly create/delete in rapid succession, activerecord writes could be eliminated 
  # with better logic
  def update_rm_assignments

    #Obtain rm applications assigned to user
    @rm_apps = @rm_person.accessible_applications
    
    # Ensure application_assignments matches @rm_apps for apps which come from RM.
    # Note that some apps (bookmarks) do not come from RM and further, some RM apps
    # may have portal-side data (i.e. 'favorited').
    @rm_apps.each do |app|
      app_assignment = @person.application_assignments.find_or_create_by_rm_application_id(app[:id])
      
      #Ensure rm_app_data for given app was recently updated
      app_attribute = RmApplicationAttribute.find_or_create_by_rm_application_id(app[:id])
      if app_attribute.updated_at < 72.hours.ago
        #query rm application for particular attributes on the application
        @app_attribute_data = RmApplication.find(app[:id])
        #record data into app_attribute
        app_attribute.name = @app_attribute_data.name
        app_attribute.description = @app_attribute_data.description
        app_attribute.url = @app_attribute_data.url
#        app_attribute.icon_path = @app_attribute_data.icon_path
        app_attribute.save
      end

      # Verifies RM had icon data, otherwise uses default icon
      # if @rm_app_data.image.present?                           Icon field does not currently exist in RM
      #   app_assignment.image = app_attribute.image    
#       else
#     app.assignment.image = 
      # end

#      end

      #If url is blank, remove assignment
#      if app_attribute.url.blank?
#        app_assignment.destroy
#      else
        # Update attributes
        app_assignment.name = app_attribute.name
        app_assignment.description = app_attribute.description
        app_assignment.url = app_attribute.url
        #assign image to app assignment
        first_letter = app_assignment.name.chars.first.downcase
        icon_path = Icon.find_by_letter(first_letter).image.url
        app_assignment.image = icon_path
        app_assignment.save!
#      end
    end
    # Go through @person.application_assignments and remove any non-bookmark ones which are not in @rm_apps
    @person.application_assignments.keep_if do |assignment|
      assignment.bookmark or @rm_apps.find_index{ |r| r[:id] == assignment.rm_application_id }
    end
    
    @person.save!
  end
end
