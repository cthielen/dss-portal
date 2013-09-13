class PeopleController < ApplicationController 
  respond_to :html, :json
  def update
    @person.update_attributes(params[:person])
    respond_with @person
  end
end
