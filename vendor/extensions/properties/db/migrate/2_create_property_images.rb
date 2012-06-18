class CreatePropertyImages < ActiveRecord::Migration
  def change
    create_table :refinery_property_images do |t|
      t.integer :image_id
      t.integer :property_id
      t.integer :position
    end

    add_index :refinery_property_images, :image_id
    add_index :refinery_property_images, :property_id
  end
end
