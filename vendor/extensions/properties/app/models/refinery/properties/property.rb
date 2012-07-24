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
      
      has_one :location, :class_name => 'Refinery::LocationExplorer::Location', :foreign_key => 'owner_id', :dependent => :destroy
      accepts_nested_attributes_for :location
      
      delegate :latitude, :longitude, :to => :location, :allow_nil => true

      scope :available_now, where(:availability_status => 'available now')      
      scope :not_available_now, where(["availability_status != ?", 'available now'])
      scope :saleable_order, order("availability_status, position").where("availability_status LIKE 'available%'")

      def lot_name
        "Lot #{lot_number}"
      end

      def latlng
        [latitude, longitude] if latitude && longitude
      end
      
      def latitude=(value)
        return nil if value.empty?
        ensure_location
        self.location.latitude = value
      end
      
      def longitude=(value)
        return nil if value.empty?
        ensure_location
        self.location.longitude = value
      end

      def colour
        '990099'
      end

      def name
        lot_name
      end

      def preview_image_url(size = "253x160#c")
        image = images.first
        image.thumbnail(size).url if image
      end

      def first_image
        images.first
      end

      def description_preview
        headline
      end

      private

        def ensure_location
          build_location(:owner => self) unless location
        end
    end
  end
end
