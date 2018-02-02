Rails.application.routes.draw do
  root 'application#index'
  namespace :api do
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: 'auth', controllers: {
        registrations: 'api/v1/overrides/registrations'
      }
      resources :organizations
      get '/organization/contacts', to: 'contacts#list'
      get '/organization/:org_id/contacts', to: 'contacts#index'
      post '/organization/:org_id/contacts', to: 'contacts#create'
      get '/organization/:org_id/contacts/:contact_id', to: 'contacts#show'
      put '/organization/:org_id/contacts/:contact_id', to: 'contacts#update'
      delete '/organization/:org_id/contacts/:contact_id', to: 'contacts#destroy'

      #Bonus
      post '/organization/send_contacts', to: 'contacts#send_email'

      #Cards
      get '/cards', to: 'cards#list'
      post '/send_card', to: 'cards#send_email'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
