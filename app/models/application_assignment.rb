class ApplicationAssignment < ActiveRecord::Base
  using_access_control
  
  belongs_to :person
  belongs_to :cached_application

  validates_presence_of :person_id, :cached_application, :position

  accepts_nested_attributes_for :cached_application, allow_destroy: true
  
  # Give a new assignment a position (default to max)
  before_validation( :on => :create ) do
    max_position = ApplicationAssignment.where(:person_id => self.person_id).collect { | assignment | assignment.position }.max
    self.position = max_position ? max_position + 1 : 1
  end

  attr_accessible :favorite, :person_id, :position, :bookmark, :cached_application_attributes

  def as_json(options={})
    {
      :id => self.id,
      :favorite => self.favorite,
      :position => self.position,
      :person_id => self.person_id,
      :bookmark => self.bookmark,
      :cached_application => self.cached_application
    }
  end
end
