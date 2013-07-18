class ApplicationAssignmentsController < ApplicationController
  # GET /application_assignments
  # GET /application_assignments.json
  def index
    @application_assignments = ApplicationAssignment.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @application_assignments }
    end
  end

  # GET /application_assignments/1
  # GET /application_assignments/1.json
  def show
    @application_assignment = ApplicationAssignment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @application_assignment }
    end
  end

  # GET /application_assignments/new
  # GET /application_assignments/new.json
  def new
    @application_assignment = ApplicationAssignment.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @application_assignment }
    end
  end

  # GET /application_assignments/1/edit
  def edit
    @application_assignment = ApplicationAssignment.find(params[:id])
  end

  # POST /application_assignments
  # POST /application_assignments.json
  def create
    @application_assignment = ApplicationAssignment.new(params[:application_assignment])

    respond_to do |format|
      if @application_assignment.save
        format.html { redirect_to @application_assignment, notice: 'Application assignment was successfully created.' }
        format.json { render json: @application_assignment, status: :created, location: @application_assignment }
      else
        format.html { render action: "new" }
        format.json { render json: @application_assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /application_assignments/1
  # PUT /application_assignments/1.json
  def update
    @application_assignment = ApplicationAssignment.find(params[:id])

    respond_to do |format|
      if @application_assignment.update_attributes(params[:application_assignment])
        format.html { redirect_to @application_assignment, notice: 'Application assignment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @application_assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /application_assignments/1
  # DELETE /application_assignments/1.json
  def destroy
    @application_assignment = ApplicationAssignment.find(params[:id])
    @application_assignment.destroy

    respond_to do |format|
      format.html { redirect_to application_assignments_url }
      format.json { head :no_content }
    end
  end
end
