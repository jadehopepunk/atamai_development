class CreateLocationsLocations < ActiveRecord::Migration

  def up
    create_table :refinery_locations do |t|
      t.string :name
      t.text :description
      t.decimal :latitude
      t.decimal :longitude
      t.integer :position

      t.timestamps
    end

  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-locations"})
    end

    if defined?(::Refinery::Page)
      ::Refinery::Page.delete_all({:link_url => "/locations/locations"})
    end

    drop_table :refinery_locations

  end

end
