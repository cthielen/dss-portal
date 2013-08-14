class ApplicationAssignment < ActiveRecord::Base
  scope :favorite, -> { where(favorite: true) }
  scope :non_favorite, -> { where(favorite: false) }
  
  belongs_to :person
  attr_accessible :favorite, :person_id, :position, :name, :url, :description, :bookmark, :rm_application_id
end
