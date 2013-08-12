class ApplicationAssignmentsController < ApplicationController
  # GET /applications
  # GET /applications.json
  def index
    @applications = ApplicationAssignment.all(:order => 'favorite, position')
    
    # Containers to be rendered as json
    @apps = Array.new
    @favorites = Array.new
    
    app = Hash.new
    
    # Collect list of RM apps
    @applications.each do |app|
      if(app.favorite == false)
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
end
