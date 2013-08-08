class Person < ActiveRecord::Base
  has_many :applications
  attr_accessible :loginid, :name
end
