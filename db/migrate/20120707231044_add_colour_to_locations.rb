class AddColourToLocations < ActiveRecord::Migration
  def change
  	add_column 'refinery_locations', 'colour_override', :string, :length => 6
  end
end
