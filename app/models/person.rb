class Person < ActiveRecord::Base
  has_many :application_assignments
  attr_accessible :loginid, :name
end
