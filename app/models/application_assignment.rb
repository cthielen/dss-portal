class ApplicationAssignment < ActiveRecord::Base
  scope :favorite, -> { where(favorite: true) }
  scope :non_favorite, -> { where(favorite: false) }

  belongs_to :person
  belongs_to :cached_application

  validates_presence_of :person_id
  validates_presence_of :cached_application

  attr_accessible :favorite, :person_id, :position, :bookmark, :cached_application_id

  def as_json(options={})
    { :id => self.id, :favorite => self.favorite, :position => self.position, :person_id => self.person_id, :bookmark => self.bookmark, :name => self.cached_application.name, :url => self.cached_application.url, :description => self.cached_application.description, :icon => self.cached_application.icon_path }
  end
end
