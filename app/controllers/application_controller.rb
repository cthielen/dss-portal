class ApplicationController < ActionController::Base
  before_filter CASClient::Frameworks::Rails::Filter
  before_filter :set_current_user
  before_filter :find_or_create_person
  before_filter :update_rm_assignments
  protect_from_forgery
  
  def welcome
    unless session[:cas_user].nil?
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
    @rmperson = RmPerson.find(session[:cas_user])
  end

  def update_rm_assignments
    @rm_apps = @rmperson.accessible_applications
    logger.info "TEST TEST TEST TEST"    
    logger.info @rm_apps
    logger.info "TST TST TST TST"    
    logger.info @person.application_assignments

    #@person.applications compared against @rm_apps
    #loop through that list of applications and ensure that it matches the same list in rm_application_assignments - add or remove as necessary
    
  end
end
