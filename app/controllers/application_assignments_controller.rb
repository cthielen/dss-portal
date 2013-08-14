class ApplicationAssignmentsController < ApplicationController
  # GET /applications
  # GET /applications.json
  def index
    @applications = ApplicationAssignment.all(:order => 'favorite, position')
    
    # Containers to be rendered as json
    @apps = []
    @favorites = []
    
    app = {}
    
    # Collect list of RM apps
    @applications.each do |app|
      if(app.favorite != true)
        @apps << { :name => app.name, :id => app.id, :url => app.url, :description => app.description}
      else 
        @favorites << { :name => app.name, :id => app.id, :url => app.url, :description => app.description}
      end
    end
      
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @applications }
    end
  end

  def drag_update
    logger.info "DRAG_UPDATE DRAG_UPDATE DRAG_UPDATE DRAG_UPDATE DRAG_UPDATE DRAG_UPDATE"
    @assignments = params[:pageLayout]
    logger.info @assignments
#    favPosition = 1
#    appPosition = 1

#    @assignments.each do |a|
#    logger.info a
#    end

#    logger.info @assignment[0][:favorite]
#    @assignments.each do |assignment|
#      record = ApplicationAssignment.find(@assignment[:id])    
#      record.favorite = @assignment[:favorite]
#      if @assignment[:favorite] == "true"
#      
#        logger.info "TRUE" 
#        logger.info @assignment.favorite
#        record.position = favPosition
#        favPosition += 1     
#      else
#        record.position = appPosition
#        appPosition += 1
#      end
      #record.save
#    end
    render :json => {:status => "success"}
  end
end
