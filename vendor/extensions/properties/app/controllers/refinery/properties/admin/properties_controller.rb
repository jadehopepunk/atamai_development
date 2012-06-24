module Refinery
  module Properties
    module Admin
      class PropertiesController < ::Refinery::AdminController

        crudify :'refinery/properties/property',
                :title_attribute => 'lot_number', :xhr_paging => true

        def update
          if @property.update_attributes(params[:property])
            flash.notice = t(
              'refinery.crudify.updated',
              :what => "'#{@property.lot_number}'"
            )

            unless from_dialog?
              unless params[:continue_editing] =~ /true|on|1/
                redirect_back_or_default(refinery.properties_admin_properties_path)
              else
                unless request.xhr?
                  redirect_to :back
                else
                  render :partial => '/refinery/message'
                end
              end
            else
              self.index
              @dialog_successful = true
              render :index
            end
          else
            unless request.xhr?
              render :action => 'edit'
            else
              render :partial => '/refinery/admin/error_messages', :locals => {
                       :object => @property,
                       :include_object_name => true
                     }
            end
          end
        end
      end
    end
  end
end
