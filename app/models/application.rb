class Application < ActiveRecord::Base
  belongs_to :person
  attr_accessible :favorite, :person_id, :position, :name, :url, :description, :bookmark, :application_id
end
