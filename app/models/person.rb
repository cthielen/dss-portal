class Person < ActiveRecord::Base
  using_access_control
  
  has_many :application_assignments, :dependent => :destroy

  validates_presence_of :loginid

  attr_accessible :loginid, :name, :application_assignments_attributes
  
  accepts_nested_attributes_for :application_assignments, :allow_destroy => true

  def as_json(options={})
    { :loginid => self.loginid, :id => self.id, :application_assignments => self.application_assignments }
  end

  def rm_person
    begin
      @rm_person ||= RmPerson.find(loginid)
    rescue => e
      Rails.logger.error "ActiveResource error while fetching user with login #{loginid}: '#{e}'."
      raise ApplicationController::RmUnreachable
    end
  end

  # Returns identifying string for logging purposes. Useful if you need multiple models for users
  def log_identifier
    loginid
  end
  
  def role_symbols
    tokens = []

    rm_person.role_assignments.each do |r|
      tokens << r.token.to_sym if r.application_name == "DSS Portal"
      end
    tokens
  end
  
  # Updates local data with information from RM API
  def refresh!    
    # Update basic attributes
    self.name = rm_person.name
    self.rm_id = rm_person.id

    # Update accessible applications (application_assignments)
    rm_person.accessible_applications.each do |app|
      application = CachedApplication.find_or_initialize_by_rm_id(app[:id])
      
      application.refresh!
      
      # Ensure this application_assignment exists
      application_assignments.find_or_create_by_person_id_and_cached_application_id(self.id, application.id)
    end
    
    # Removing non-bookmarked assignments no longer in RM
    application_assignments.each do |assignment|
      unless assignment.bookmark or rm_person.accessible_applications.find_index{ |r| r[:id] == assignment.cached_application.rm_id }
        assignment.delete
      end
    end
  
    self.save!
  end
end
