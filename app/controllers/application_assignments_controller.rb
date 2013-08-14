class ApplicationAssignmentsController < ApplicationController
  # GET /applications
  # GET /applications.json
  def index
    @apps = @person.application_assignments.non_favorite.all(:order => 'favorite, position')
    @favorites = @person.application_assignments.favorite.all(:order => 'favorite, position')
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @applications }
    end
  end

  def drag_update
    logger.info "DRAG_UPDATE DRAG_UPDATE DRAG_UPDATE DRAG_UPDATE DRAG_UPDATE DRAG_UPDATE"
    assignments = params[:pageLayout]
    favPosition = 1
    appPosition = 1
    assignments.each do |assignment|
      record = ApplicationAssignment.find(assignment[:app_id])    
      record.favorite = assignment[:favorite]
      if assignment[:favorite] == "true"
        record.position = favPosition
        favPosition += 1     
      else 
        record.position = appPosition
        appPosition += 1
      end
      record.save
    end
   render :json => {:status => "success"}
  end
end
