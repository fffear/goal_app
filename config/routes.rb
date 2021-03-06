Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: %i(index new create show)
  resources :goals do
    post "complete", on: :member
  end
  resource :session, only: %i(new create destroy)

  root to: 'users#index'
end
