module Refinery
  module Properties
    class Property < Refinery::Core::BaseModel
      self.table_name = 'refinery_properties'

      AVAILABILITY_STATES = ['available now', 'available soon', 'under offer', 'sold']

      attr_accessible :lot_number, :headline, :description, :potential_uses,
        :position, :total_price, :availability_status, :land_area_sqm,
        :street_address, :latitude, :longitude

      acts_as_indexed :fields => [:lot_number, :headline, :description, :potential_uses]

      validates :lot_number, :presence => true, :uniqueness => true

      has_many_page_images
      
      has_one :location, :class_name => 'Refinery::Locations::Location', :foreign_key => 'owner_id', :dependent => :destroy
      accepts_nested_attributes_for :location
      
      delegate :latitude, :longitude, :to => :location, :allow_nil => true
      
      def lot_name
        "Lot #{lot_number}"
      end

      def latlng
        [latitude, longitude] if latitude && longitude
      end
      
      def latitude=(value)
        ensure_location
        self.location.latitude = value
      end
      
      def longitude=(value)
        ensure_location
        self.location.longitude = value
      end

      def colour
        '990099'
      end

      private

        def ensure_location
          build_location(:owner => self) unless location
        end
    end
  end
end
