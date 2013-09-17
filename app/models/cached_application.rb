class CachedApplication < ActiveRecord::Base
  using_access_control
  
  validates_presence_of :rm_id

  attr_accessible :description, :name, :url, :rm_id
  
  # Updates local data with information from RM API
  def refresh!
    rm_app_data = RmApplication.find(rm_id)
    
    self.name = rm_app_data.name
    self.description = rm_app_data.description
    self.url = rm_app_data.url
    
    if rm_app_data.icon and rm_app_data.icon.length > 0
      self.icon_path = "https://roles.dss.ucdavis.edu/" + rm_app_data.icon
    else
      self.icon_path = "/assets/#{rm_app_data.name[0].downcase}.jpg"
    end
    
    self.save! if self.changed?
  end
end
