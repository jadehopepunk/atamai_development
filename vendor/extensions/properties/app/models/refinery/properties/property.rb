module Refinery
  module Properties
    class Property < Refinery::Core::BaseModel
      self.table_name = 'refinery_properties'

      attr_accessible :lot_number, :headline, :description, :potential_uses, :main_image,
        :main_image_id, :position, :total_price, :availability_status, :land_area_sqm

      acts_as_indexed :fields => [:lot_number, :headline, :description, :potential_uses]

      validates :lot_number, :presence => true, :uniqueness => true

      belongs_to :main_image, :class_name => '::Refinery::Image'

      def lot_name
        "Lot #{lot_number}"
      end
    end
  end
end
