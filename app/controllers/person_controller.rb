class PersonController < ApplicationController 
  def update
    @person.update_attributes(params[:application_assignment])
    respond_with @person
  end
end
