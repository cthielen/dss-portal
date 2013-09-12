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
    logger.info params[:pageLayout]
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
     first_letter = @assignment.name.chars.first.downcase
     icon_path = Icon.find_by_letter(first_letter).image.url
     @assignment.image = icon_path
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
    if @bookmark_app.destroy
      render :json => {:status => "success"}
    else
      render :json => {:status => "failure"}
    end
    
  end

  def manage
    @bookmark_apps = @person.application_assignments.where(:bookmark => true)
  end

   def update
    @assignment = ApplicationAssignment.find(params[:id])
#    submission_hash = {"name" => params[:name],"description" => params[:description],"url" => params[:url]}
    @assignment.update_attributes(params[:application_assignment])
    render :json => {:status => "success"}
  end

  def create
    @assignment = @person.application_assignments.new(params[:application_assignment])
    @assignment.bookmark = true
    @assignment.favorite = false
    first_letter = @assignment.name.chars.first.downcase
    icon_path = Icon.find_by_letter(first_letter).image.url
    @assignment.image = icon_path
    logger.info "TESTETTSESETSEETS"
    logger.info @assignment.bookmark
    logger.info @assignment.favorite
    @assignment.save
    render :json => {:status => 200, :assignment => @assignment}
  end
end
