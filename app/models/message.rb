class Message < ActiveRecord::Base
  attr_accessible :description, :guid, :published, :title
end
