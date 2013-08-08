class ApplicationAssignmentsController < ApplicationController
  # GET /applications
  # GET /applications.json
  def index
    @applications = ApplicationAssignment.all

		@apps = Array.new
		app = Hash.new
		#collect list of RM apps
		@applications.each do |app|		
			@apps << { :name => app.name, :id => app.id}
		end


    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @applications }
    end
  end
end
