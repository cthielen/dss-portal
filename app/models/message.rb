class Message < ActiveRecord::Base
  attr_accessible :description, :guid, :published, :title
  
  def syncgo
    console.log "SYNCGO METHOD CALLED"
  end
end
