module Refinery
  module Locations
    class LocationsController < ::ApplicationController

      before_filter :find_all_locations
      before_filter :find_page

      def index
        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @location in the line below:
        present(@page)
      end

      def show
        @location = present_location(Location.find(params[:id]))

        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @location in the line below:
        present(@page)
      end

    protected

      def present_location(location)
        location.owner ? OwnerDecorator.new(location) : location
      end

      def find_all_locations
        @locations = Location.order('position ASC').map do |location|
          present_location(location)
        end
      end

      def find_page
        @page = ::Refinery::Page.where(:link_url => "/locations").first
      end

    end
  end
end
