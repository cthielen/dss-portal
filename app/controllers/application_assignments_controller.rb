class ApplicationAssignmentsController < ApplicationController
  respond_to :html, :json
  
  def index
    @apps = @person.application_assignments.non_favorite.all(:order => 'favorite, position')
    @favorites = @person.application_assignments.favorite.all(:order => 'favorite, position')
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
      
      record.save!
    end
  end

  def destroy
    @bookmark_app = ApplicationAssignment.find(params[:id])
    @bookmark_app.destroy
    
    respond_with @bookmark_app
  end

  def update
    @assignment = ApplicationAssignment.find(params[:id])
    @assignment.update_attributes(params[:application_assignment])
    
    respond_with @assignment
  end

  def create
    @assignment = @person.application_assignments.new(params[:application_assignment])
    @assignment.bookmark = true
    @assignment.favorite = false
    @assignment.image = "/assets/#{@assignment.name[0].downcase}.jpg"
    @assignment.save
    
    respond_with @assignment
  end
end
