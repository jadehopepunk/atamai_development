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

        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @property in the line below:
        present(@page)
      end

    protected

      def find_all_properties
        @properties_by_status = {}
        Property.order('position ASC').each do |property|
          @properties_by_status[property.availability_status] ||= []
          @properties_by_status[property.availability_status] << property
        end
      end

      def find_page
        @page = ::Refinery::Page.where(:link_url => "/properties").first
      end

    end
  end
end
