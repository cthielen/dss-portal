class Icon < ActiveRecord::Base
  attr_accessible :letter, :image
  has_attached_file :image
end
