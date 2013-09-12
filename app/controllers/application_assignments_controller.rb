class ApplicationAssignmentsController < ApplicationController
  def index
    @apps = @person.application_assignments.non_favorite.all(:order => 'favorite, position')
    @favorites = @person.application_assignments.favorite.all(:order => 'favorite, position')
    @application_assignment = @person.application_assignments.new
    
    respond_to do |format|
      format.html
      #format.json { render json: @applications }
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
    
    render :json => { :status => "success" }
  end

  def destroy
    @bookmark_app = ApplicationAssignment.find(params[:id])

    if @bookmark_app.destroy
      render :json => { :status => "success" }
    else
      render :json => { :status => "failure" }
    end
    
  end

  def update
    @assignment = ApplicationAssignment.find(params[:id])
    @assignment.update_attributes(params[:application_assignment])
    
    render :json => { :status => "success" }
  end

  def create
    @assignment = @person.application_assignments.new(params[:application_assignment])
    @assignment.bookmark = true
    @assignment.favorite = false
    @assignment.image = "/assets/#{@assignment.name[0].downcase}.jpg"
    @assignment.save
    render :json => {:status => 200, :assignment => @assignment}
  end
end
