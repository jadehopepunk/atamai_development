Refinery::Core::Engine.routes.append do

  # Frontend routes
  match 'properties' => 'properties/properties#index', :as => :properties_properties
  match 'properties/:id' => 'properties/properties#show', :constraints => { :id => /\d*/ }, :as => :properties_property

  # Admin routes
  namespace :properties, :path => '' do
    namespace :admin, :path => 'refinery' do
      resources :properties, :except => :show do
        collection do
          post :update_positions
        end
      end
    end
  end

end
