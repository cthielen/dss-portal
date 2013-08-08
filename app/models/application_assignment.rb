class ApplicationAssignment < ActiveRecord::Base
  belongs_to :person
  attr_accessible :favorite, :person_id, :position, :name, :url, :description, :bookmark, :rm_application_id
end
