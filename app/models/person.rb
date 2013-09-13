class Person < ActiveRecord::Base
  validates_presence_of :loginid

  has_many :application_assignments, :dependent => :destroy

  attr_accessible :loginid, :name
  def as_json(options={})
    {:loginid       => self.loginid,
      :id => self.id,
     :application_assignments => self.application_assignments}
  end
end
