class ApplicationController < ActionController::Base
	before_filter CASClient::Frameworks::Rails::Filter
	before_filter :set_current_user
	protect_from_forgery
  
  def welcome
    unless session[:cas_user].nil?
	  redirect_to :controller => 'application', :action => 'index'
    end

  end
  
def logout
    logger.info "#{session[:cas_user]}@#{request.remote_ip}: Logged out."
    CASClient::Frameworks::Rails::Filter.logout(self)
  end
  
	def set_current_user
		Authorization.current_user = Person.find(session[:cas_user])
		@current_user = Authorization.current_user
		logger.info "#{session[:cas_user]}@#{request.remote_ip}: Set current user to #{Authorization.current_user.inspect}."
	end


	# def current_user
	#   Authorization.current_user
	# end  
end
