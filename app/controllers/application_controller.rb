class ApplicationController < ActionController::Base
	before_filter CASClient::Frameworks::Rails::Filter
	before_filter :set_current_user
  before_filter :find_or_create_person
  before_filter :update_rm_assignments
	protect_from_forgery
  
  def welcome
    unless session[:cas_user].nil?
	  redirect_to :controller => 'applications', :action => 'index'
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
    @person = Person.find_by_loginid(@current_user)
    if @person == nil
      @rmperson = RmPerson.find(@current_user)
      @person = Person.new
      @person.name = @rmperson.name
      @person.loginid = @rmperson.loginid
    end
  end

  def update_rm_assignments
  
  end

	# def current_user
	#   Authorization.current_user
	# end  
end
