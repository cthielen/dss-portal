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
    Authorization.current_user = RmPerson.find(session[:cas_user])
    @current_user = Authorization.current_user
    logger.info "#{session[:cas_user]}@#{request.remote_ip}: Set current user to #{Authorization.current_user.inspect}."
  end
  
  def find_or_create_person
    @person = Person.find_or_create_by_loginid(session[:cas_user])
    @rm_person = RmPerson.find(session[:cas_user])
  end

  def update_rm_assignments
    @rm_apps = @rm_person.accessible_applications
    
    # Ensure application_assignments matches @rm_apps for apps which come from RM.
    # Note that some apps (bookmarks) do not come from RM and further, some RM apps
    # may have portal-side data (i.e. 'favorited').
    @rm_apps.each do |app|
      app_assignment = @person.application_assignments.find_or_create_by_rm_application_id(app[:id])
      
      # Update attributes
      app_assignment.name = app[:name]
      #app_assignment.description = role.description RM does not currently publish application descriptions this way.
      #app_assignment.url = app.url
      app_assignment.save!
    end
    
    # Go through @person.application_assignments and remove any non-bookmark ones which are not in @rm_apps
    @person.application_assignments.keep_if do |assignment|
      assignment.bookmark or @rm_apps.find_index{ |r| r[:id] == assignment.rm_application_id }
    end
    
    @person.save!
  end
end
