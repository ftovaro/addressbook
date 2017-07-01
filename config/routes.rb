Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: 'auth', controllers: {
        registrations: 'api/v1/overrides/registrations'
      }
      resources :organizations
      resources :contacts
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
