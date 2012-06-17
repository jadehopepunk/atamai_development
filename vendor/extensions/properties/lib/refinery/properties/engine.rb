module Refinery
  module Properties
    class Engine < Rails::Engine
      include Refinery::Engine
      isolate_namespace Refinery::Properties

      engine_name :refinery_properties

      initializer "register refinerycms_properties plugin" do
        Refinery::Plugin.register do |plugin|
          plugin.name = "properties"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.properties_admin_properties_path }
          plugin.pathname = root
          plugin.activity = {
            :class_name => :'refinery/properties/property',
            :title => 'lot_number'
          }
          
        end
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::Properties)
      end
    end
  end
end
