class RmApplicationAssignment < ActiveRecord::Base
  has_one :application, :as => :category
  attr_accessible :application_id, :loginid
end
