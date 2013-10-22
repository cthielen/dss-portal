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
    rescue Exception => e
      Rails.logger.error "ActiveResource error while fetching user with login #{loginid}: '#{e}'."
      raise ActionController::RoutingError.new('Roles Management not reachable')
    end
  end

  # Returns identifying string for logging purposes. Useful if you need multiple models for users
  def log_identifier
    loginid
  end
  
  def role_symbols
    tokens = []

    rm_person.role_assignments.each do |r|
      tokens << r.token.to_sym if r.application_name == "DSS Messenger"
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
      # Disable access control as a regular user will be updating a CachedApplication.
      # This is safe as the data is pulled from RM and is self-contained in this function.
      # There's no simple way to do this in authorization_rules afaik.
      Authorization.ignore_access_control(true)
      
      application = CachedApplication.find_or_initialize_by_rm_id(app[:id])
      
      application.refresh!
      
      Authorization.ignore_access_control(false)
      
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
