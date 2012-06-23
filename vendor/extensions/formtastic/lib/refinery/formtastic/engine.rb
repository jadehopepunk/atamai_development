module Refinery
  module Formtastic
    class Engine < Rails::Engine
      isolate_namespace Refinery::Formtastic

      config.after_initialize do
        Refinery::Core.config.register_stylesheet("formtastic")
        Refinery::Core.config.register_stylesheet("refinery/formtastic/admin")
      end
    end
  end
end
