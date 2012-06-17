class CreatePropertiesProperties < ActiveRecord::Migration
  def up
    create_table :refinery_properties do |t|
      t.string :lot_number
      t.string :headline
      t.integer :total_price
      t.string :availability_status
      t.integer :land_area_sqm
      t.text :description
      t.text :potential_uses
      t.integer :main_image_id
      t.integer :position

      t.timestamps
    end
  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-properties"})
    end

    if defined?(::Refinery::Page)
      ::Refinery::Page.delete_all({:link_url => "/properties/properties"})
    end

    drop_table :refinery_properties
  end
end
