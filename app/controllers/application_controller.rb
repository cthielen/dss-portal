class ApplicationController < ActionController::Base
  before_filter CASClient::Frameworks::Rails::Filter
  before_filter :set_current_user
  protect_from_forgery
  
  def current_user
    Person.includes(:application_assignments).find_or_create_by_loginid(session[:cas_user])
  end
  
  def set_current_user
    Authorization.current_user = current_user
  end
end
