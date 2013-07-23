class Application < ActiveRecord::Base
  belongs_to :person
  belongs_to :category, polymorphic: true
  attr_accessible :favorite, :person_id, :position, :category_type, :category_id
end
