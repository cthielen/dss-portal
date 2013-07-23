class Person < ActiveRecord::Base
  has_many :rm_application_assignments
  has_many :bookmark_assignments
  has_many :applications
  accepts_nested_attributes_for :applications, :rm_application_assignments, :bookmark_assignments
  attr_accessible :loginid, :name
end
