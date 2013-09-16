class PeopleController < ApplicationController 
  respond_to :html, :json

  def update
    logger.info "#{current_user.log_identifier}@#{request.remote_ip}: Updated person #{params[:person]}."
    
    @person.update_attributes(params[:person])

    respond_with @person
  end
end
