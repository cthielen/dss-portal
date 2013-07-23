class Application < ActiveRecord::Base
  belongs_to :category, polymorphic: true
  attr_accessible :favorite, :person_id, :position, :category_type, :type_id
end
