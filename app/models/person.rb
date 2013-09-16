class Person < ActiveRecord::Base
  has_many :application_assignments, :dependent => :destroy

  validates_presence_of :loginid

  attr_accessible :loginid, :name

  def as_json(options={})
    { :loginid => self.loginid, :id => self.id, :application_assignments => self.application_assignments }
  end
  
  # Returns identifying string for logging purposes. Useful if you need multiple models for users
  def log_identifier
    loginid
  end
  
  # Updates local data with information from RM API
  def refresh!
    rm_person = RmPerson.find(loginid)
    
    # Update basic attributes
    self.name = rm_person.name
    self.rm_id = rm_person.id
    
    # Update accessible applications (application_assignments)
    rm_person.accessible_applications.each do |app|
      application = CachedApplication.find_or_create_by_rm_id(app[:id])
      
      application.refresh!
      
      # Ensure this application_assignment exists
      application_assignments.find_or_create_by_person_id_and_cached_application_id(self.id, application.id)
    end
    
    # Removing non-bookmarked assignments no longer in RM
    application_assignments.keep_if do |assignment|
      assignment.bookmark or rm_person.accessible_applications.find_index{ |r| r[:id] == assignment.cached_application.rm_id }
    end
  
    save!
  end
end
