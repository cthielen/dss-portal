class Message < ActiveRecord::Base
  attr_accessible :description, :guid, :published, :title
  
  def syncgo
    puts "SYNCGO METHOD CALLED"
    
  end
end
