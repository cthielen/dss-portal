class Application < ActiveRecord::Base
  attr_accessible :favorite, :person_id, :position, :type, :type_id
end
