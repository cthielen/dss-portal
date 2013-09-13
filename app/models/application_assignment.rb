class ApplicationAssignment < ActiveRecord::Base
  scope :favorite, -> { where(favorite: true) }
  scope :non_favorite, -> { where(favorite: false) }

  belongs_to :person
  belongs_to :rm_application_attribute

  validates_presence_of :person_id
  validates_presence_of :rm_application_attribute

  attr_accessible :favorite, :person_id, :position, :bookmark, :rm_application_attribute_id

  def as_json(options={})
    { :id => self.id, :favorite => self.favorite, :position => self.position, :person_id => self.person_id, :bookmark => self.bookmark, :name => self.rm_application_attribute.name, :url => self.rm_application_attribute.url, :description => self.rm_application_attribute.description, :icon => self.rm_application_attribute.icon_path }
  end
end
