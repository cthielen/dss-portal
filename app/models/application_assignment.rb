class ApplicationAssignment < ActiveRecord::Base
  scope :favorite, -> { where(favorite: true) }
  scope :non_favorite, -> { where(favorite: false) }

  belongs_to :person
  belongs_to :rm_application

  validates_presence_of :person_id
  validates_presence_of :name

  attr_accessible :favorite, :person_id, :position, :name, :url, :description, :bookmark
end
