module Refinery
  module Locations
    class Location < Refinery::Core::BaseModel
      self.table_name = 'refinery_locations'

      attr_accessible :name, :description, :latitude, :longitude, :position

      acts_as_indexed :fields => [:name, :description]

      validates :name, :presence => true, :uniqueness => true

      has_many_page_images

      def description_preview
        if description
          matches = description.match(/<p>(.*)<\/p>/)
          text = matches ? matches[1] : description
          text.truncate(200)
        end
      end
    end
  end
end
