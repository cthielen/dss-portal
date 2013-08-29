class Person < ActiveRecord::Base
  has_many :application_assignments, :dependent => :destroy
  attr_accessible :loginid, :name
  validates :loginid, presence: true
end
