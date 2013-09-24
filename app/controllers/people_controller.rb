class PeopleController < ApplicationController
  filter_resource_access
  respond_to :json

  def update
    logger.info "#{current_user.log_identifier}@#{request.remote_ip}: Updated person #{params[:person]}."
    
    @person.update_attributes(params[:person])

    respond_with @person
  end
end
