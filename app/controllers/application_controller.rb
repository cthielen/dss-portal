class ApplicationController < ActionController::Base
  before_filter CASClient::Frameworks::Rails::Filter
  before_filter :set_current_user
  protect_from_forgery
  require 'declarative_authorization/maintenance'
  include Authorization::Maintenance

  def current_user
    without_access_control do
      Person.includes(:application_assignments).find_or_create_by_loginid(session[:cas_user])
    end
  end
  
  def set_current_user
    Authorization.current_user = current_user
  end
  
  # Handling errors
  class RmUnreachable < StandardError; end
  rescue_from RmUnreachable, :with => :render_rm_unreachable

  def render_rm_unreachable
    respond_to do |format| 
      format.html { render :template => "errors/tech_difficulties", :status => 500, :layout => "error" } 
    end
    true
  end
end
