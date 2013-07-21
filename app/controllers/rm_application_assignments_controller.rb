class RmApplicationAssignmentsController < ApplicationController
  # GET /rm_application_assignments
  # GET /rm_application_assignments.json
  def index
    @rm_application_assignments = RmApplicationAssignment.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @rm_application_assignments }
    end
  end

  # GET /rm_application_assignments/1
  # GET /rm_application_assignments/1.json
  def show
    @rm_application_assignment = RmApplicationAssignment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @rm_application_assignment }
    end
  end

  # GET /rm_application_assignments/new
  # GET /rm_application_assignments/new.json
  def new
    @rm_application_assignment = RmApplicationAssignment.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @rm_application_assignment }
    end
  end

  # GET /rm_application_assignments/1/edit
  def edit
    @rm_application_assignment = RmApplicationAssignment.find(params[:id])
  end

  # POST /rm_application_assignments
  # POST /rm_application_assignments.json
  def create
    @rm_application_assignment = RmApplicationAssignment.new(params[:rm_application_assignment])

    respond_to do |format|
      if @rm_application_assignment.save
        format.html { redirect_to @rm_application_assignment, notice: 'Rm application assignment was successfully created.' }
        format.json { render json: @rm_application_assignment, status: :created, location: @rm_application_assignment }
      else
        format.html { render action: "new" }
        format.json { render json: @rm_application_assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /rm_application_assignments/1
  # PUT /rm_application_assignments/1.json
  def update
    @rm_application_assignment = RmApplicationAssignment.find(params[:id])

    respond_to do |format|
      if @rm_application_assignment.update_attributes(params[:rm_application_assignment])
        format.html { redirect_to @rm_application_assignment, notice: 'Rm application assignment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @rm_application_assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rm_application_assignments/1
  # DELETE /rm_application_assignments/1.json
  def destroy
    @rm_application_assignment = RmApplicationAssignment.find(params[:id])
    @rm_application_assignment.destroy

    respond_to do |format|
      format.html { redirect_to rm_application_assignments_url }
      format.json { head :no_content }
    end
  end
end
