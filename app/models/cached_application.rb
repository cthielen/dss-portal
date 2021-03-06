class CachedApplication < ActiveRecord::Base
  using_access_control
  
  has_many :application_assignments
  
  validates_uniqueness_of :rm_id, :allow_blank => true
  validate :can_only_have_one_assignment_if_non_rm_app
  
  attr_accessible :description, :name, :url, :rm_id, :icon_path
  
  def as_json(options={})
    {
      :id => self.id,
      :name => self.name,
      :description => self.description,
      :url => self.url,
      :icon_path => self.icon_path
    }
  end

  # Updates local data with information from RM API
  def refresh!
    # Save on some network requests by updating applications once a day
    if self.updated_at.nil? or self.updated_at < DateTime.yesterday
      rm_app_data = RmApplication.find(rm_id)
      
      self.name = rm_app_data.name
      self.description = rm_app_data.description
      self.url = rm_app_data.url
      
      if rm_app_data.icon and rm_app_data.icon.length > 0
        self.icon_path = "https://roles.dss.ucdavis.edu/" + rm_app_data.icon
      else
        self.icon_path = "/assets/#{rm_app_data.name[0].downcase}.jpg"
      end
    
      self.save!
    end
  end
  
  private
  
  def can_only_have_one_assignment_if_non_rm_app
    unless rm_id
      if application_assignments.count > 1
        errors.add(:base, "non-RM cached applications can only have one application assignment (they are personal bookmarks)")
      end
    end
  end
end
