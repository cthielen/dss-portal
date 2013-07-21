class BookmarkAssignmentsController < ApplicationController
  # GET /bookmark_assignments
  # GET /bookmark_assignments.json
  def index
    @bookmark_assignments = BookmarkAssignment.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @bookmark_assignments }
    end
  end

  # GET /bookmark_assignments/1
  # GET /bookmark_assignments/1.json
  def show
    @bookmark_assignment = BookmarkAssignment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @bookmark_assignment }
    end
  end

  # GET /bookmark_assignments/new
  # GET /bookmark_assignments/new.json
  def new
    @bookmark_assignment = BookmarkAssignment.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @bookmark_assignment }
    end
  end

  # GET /bookmark_assignments/1/edit
  def edit
    @bookmark_assignment = BookmarkAssignment.find(params[:id])
  end

  # POST /bookmark_assignments
  # POST /bookmark_assignments.json
  def create
    @bookmark_assignment = BookmarkAssignment.new(params[:bookmark_assignment])

    respond_to do |format|
      if @bookmark_assignment.save
        format.html { redirect_to @bookmark_assignment, notice: 'Bookmark assignment was successfully created.' }
        format.json { render json: @bookmark_assignment, status: :created, location: @bookmark_assignment }
      else
        format.html { render action: "new" }
        format.json { render json: @bookmark_assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /bookmark_assignments/1
  # PUT /bookmark_assignments/1.json
  def update
    @bookmark_assignment = BookmarkAssignment.find(params[:id])

    respond_to do |format|
      if @bookmark_assignment.update_attributes(params[:bookmark_assignment])
        format.html { redirect_to @bookmark_assignment, notice: 'Bookmark assignment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @bookmark_assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bookmark_assignments/1
  # DELETE /bookmark_assignments/1.json
  def destroy
    @bookmark_assignment = BookmarkAssignment.find(params[:id])
    @bookmark_assignment.destroy

    respond_to do |format|
      format.html { redirect_to bookmark_assignments_url }
      format.json { head :no_content }
    end
  end
end
