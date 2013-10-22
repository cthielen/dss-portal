class ApplicationAssignmentsController < ApplicationController
  filter_resource_access
  respond_to :html, :json
  before_filter only: [:index] do
   @messages = Rails.cache.fetch("algo", expires_in: 1.minutes) do
    currentMessages
   end
   logger.info "---------------------------------------------------------------------" 
   logger.info "---------------------------------------------------------------------" 
   logger.info @messages
   logger.info @messages.length
   logger.info "---------------------------------------------------------------------" 
  end
  
  def index
    logger.info "#{current_user.log_identifier}@#{request.remote_ip}: Loaded application assignments index (main page)."
    
    current_user.refresh!
    @current_user = current_user
  end

  def destroy
    logger.info "#{current_user.log_identifier}@#{request.remote_ip}: Destroyed bookmark #{params[:id]}."
    
    @bookmark_app = ApplicationAssignment.find(params[:id])
    @bookmark_app.destroy
    
    respond_with @bookmark_app
  end

  def update
    logger.info "#{current_user.log_identifier}@#{request.remote_ip}: Updated bookmark #{params[:id]}."
    
    @assignment = ApplicationAssignment.find(params[:id])
    @assignment.update_attributes(params[:application_assignment])
    
    respond_with @assignment
  end

  def create
    logger.info "#{current_user.log_identifier}@#{request.remote_ip}: Created assignment."

    @assignment = ApplicationAssignment.new(params[:application_assignment])

    respond_to do |format|
      if @assignment.save
        format.json { render json: @assignment, status: :created, location: @assignment }
      else
        format.json { render json: @assignment.errors, status: :unprocessable_entity }
      end
    end
  end

end
