class ApplicationAssignmentsController < ApplicationController
  # GET /applications
  # GET /applications.json
  def index
    @apps = @person.application_assignments.non_favorite.all(:order => 'favorite, position')
    @favorites = @person.application_assignments.favorite.all(:order => 'favorite, position')
    @application_assignment = @person.application_assignments.new
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @applications }
    end
  end

  def drag_update
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

  def create_or_update
     @assignment = @person.application_assignments.find_or_create_by_name(params[:name])
     @assignment.name = params[:name]
     @assignment.description = params[:description]
     @assignment.url = params[:url]
     @assignment.bookmark = true
     @assignment.favorite = false
     @assignment.save
    
    respond_to do |format|
     # format.html { render json: @assignment}
      format.json { render json: @assignment }
    end
  end

  def edit
    @bookmark_app = ApplicationAssignment.find(params[:id])
  end

  def destroy
    @bookmark_app = ApplicationAssignment.find(params[:id])
    @bookmark_app.destroy
  end

  def manage
    @bookmark_apps = @person.application_assignments.where(:bookmark => true)
  end
end
