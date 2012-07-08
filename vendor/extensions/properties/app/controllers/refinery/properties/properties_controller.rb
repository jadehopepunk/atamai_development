module Refinery
  module Properties
    class PropertiesController < ::ApplicationController
      helper PropertiesHelper

      before_filter :find_all_properties
      before_filter :find_page

      def index
        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @property in the line below:
        present(@page)
      end

      def show
        @property = Property.find(params[:id])
        @locations = []
        @locations << decorate_location(@property.location) if @property.location

        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @property in the line below:
        parent = @page
        @page = Page.new(:menu_title => @property.name, :title => @property.headline, :show_in_menu => true).tap {|page| page.parent = parent}
        present(@page)
      end

    protected

      def decorate_location(location)
        location.owner ? Refinery::Locations::OwnerDecorator.new(location) : location
      end

      def decorate_locations(locations)
        locations.map do |location|
          decorate_location(location)
        end
      end

      def find_all_properties
        @properties = Property.order('position ASC')
        @properties_by_status = {}
        @properties.each do |property|
          @properties_by_status[property.availability_status] ||= []
          @properties_by_status[property.availability_status] << property
        end
        @locations = decorate_locations(@properties.map(&:location).compact)
      end

      def find_page
        @page = ::Refinery::Page.where(:link_url => "/properties").first
      end

    end
  end
end
