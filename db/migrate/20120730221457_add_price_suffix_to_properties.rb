class AddPriceSuffixToProperties < ActiveRecord::Migration
  def change
    add_column :refinery_properties, :price_suffix, :string
  end
end
