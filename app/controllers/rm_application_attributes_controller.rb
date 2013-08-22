class RmApplicationAttributesController < ApplicationController
  # GET /rm_application_attributes
  # GET /rm_application_attributes.json
  def index
    @rm_application_attributes = RmApplicationAttribute.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @rm_application_attributes }
    end
  end

  # GET /rm_application_attributes/1
  # GET /rm_application_attributes/1.json
  def show
    @rm_application_attribute = RmApplicationAttribute.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @rm_application_attribute }
    end
  end

  # GET /rm_application_attributes/new
  # GET /rm_application_attributes/new.json
  def new
    @rm_application_attribute = RmApplicationAttribute.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @rm_application_attribute }
    end
  end

  # GET /rm_application_attributes/1/edit
  def edit
    @rm_application_attribute = RmApplicationAttribute.find(params[:id])
  end

  # POST /rm_application_attributes
  # POST /rm_application_attributes.json
  def create
    @rm_application_attribute = RmApplicationAttribute.new(params[:rm_application_attribute])

    respond_to do |format|
      if @rm_application_attribute.save
        format.html { redirect_to @rm_application_attribute, notice: 'Rm application attribute was successfully created.' }
        format.json { render json: @rm_application_attribute, status: :created, location: @rm_application_attribute }
      else
        format.html { render action: "new" }
        format.json { render json: @rm_application_attribute.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /rm_application_attributes/1
  # PUT /rm_application_attributes/1.json
  def update
    @rm_application_attribute = RmApplicationAttribute.find(params[:id])

    respond_to do |format|
      if @rm_application_attribute.update_attributes(params[:rm_application_attribute])
        format.html { redirect_to @rm_application_attribute, notice: 'Rm application attribute was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @rm_application_attribute.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rm_application_attributes/1
  # DELETE /rm_application_attributes/1.json
  def destroy
    @rm_application_attribute = RmApplicationAttribute.find(params[:id])
    @rm_application_attribute.destroy

    respond_to do |format|
      format.html { redirect_to rm_application_attributes_url }
      format.json { head :no_content }
    end
  end
end
