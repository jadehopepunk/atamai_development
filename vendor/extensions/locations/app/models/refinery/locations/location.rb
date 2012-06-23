module Refinery
  module Locations
    class Location < Refinery::Core::BaseModel
      self.table_name = 'refinery_locations'

      attr_accessible :name, :description, :latitude, :longitude, :position

      acts_as_indexed :fields => [:name, :description]

      validates :name, :presence => true, :uniqueness => true
    end
  end
end
