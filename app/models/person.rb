class Person < ActiveRecord::Base
  validates_presence_of :loginid

  has_many :application_assignments, :dependent => :destroy

  attr_accessible :loginid, :name
end
