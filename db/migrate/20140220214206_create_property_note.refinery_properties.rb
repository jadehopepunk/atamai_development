# This migration comes from refinery_properties (originally 2)
class CreatePropertyNote < ActiveRecord::Migration
  def up
    add_column :refinery_properties, :note_title, :string
    add_column :refinery_properties, :note_body, :string
  end

  def down
    remove_column :refinery_properties, :note_title
    remove_column :refinery_properties, :note_body
  end
end
