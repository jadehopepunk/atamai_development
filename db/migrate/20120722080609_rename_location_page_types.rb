class RenameLocationPageTypes < ActiveRecord::Migration
  def up
    Refinery::ImagePage.update_all({:page_type => "Refinery::LocationExplorer::Location"}, :page_type => "Refinery::Locations::Location")
  end

  def down
    Refinery::ImagePage.update_all({:page_type => "Refinery::Locations::Location"}, :page_type => "Refinery::LocationExplorer::Location")
  end
end
