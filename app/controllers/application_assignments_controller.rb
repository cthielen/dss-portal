class ApplicationAssignmentsController < ApplicationController
  filter_resource_access
  respond_to :html, :json
  
  def index
    logger.info "#{current_user.log_identifier}@#{request.remote_ip}: Loaded application assignments index (main page)."
    
    current_user.refresh!
    
    @apps = current_user.application_assignments.non_favorite.all(:order => 'favorite, position')
    @favorites = current_user.application_assignments.favorite.all(:order => 'favorite, position')
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
    logger.info "#{current_user.log_identifier}@#{request.remote_ip}: Created bookmark."
    
    @assignment = current_user.application_assignments.new(params[:application_assignment])
    @assignment.bookmark = true
    @assignment.favorite = false
    @assignment.image = "/assets/#{@assignment.name[0].downcase}.jpg"
    @assignment.save!
    
    respond_with @assignment
  end
end
