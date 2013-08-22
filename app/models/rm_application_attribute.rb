class RmApplicationAttribute < ActiveRecord::Base
  attr_accessible :description, :name, :urlr, :image
  has_attached_file :image
end
