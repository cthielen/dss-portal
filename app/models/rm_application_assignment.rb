class RmApplicationAssignment < ActiveRecord::Base
  has_one :application, :as => :category
  belongs_to :person
  attr_accessible :application_id, :loginid
end
