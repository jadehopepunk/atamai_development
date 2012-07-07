class PropertyHasALocation < ActiveRecord::Migration
  def up
    remove_column 'refinery_properties', :latitude
    remove_column 'refinery_properties', :longitude
    add_column 'refinery_locations', :owner_id, :integer
    add_column 'refinery_locations', :owner_type, :string
  end

  def down
    add_column 'refinery_properties', "latitude", :decimal, :precision => 12, :scale => 8
    add_column 'refinery_properties', "longitude", :decimal, :precision => 12, :scale => 8
    remove_column 'refinery_locations', :owner_id
    remove_column 'refinery_locations', :owner_type
  end
end
