Rails.application.routes.draw do
  devise_for :users
  root 'pages#index'

  namespace :api do
    namespace :v1 do
      resources :titles, except: [:new] do
        collection do
          get "/filter/(:query)", action: :index # the genre of the title
        end
        resource :favorites, only: [:create, :destroy]
      end
      resources :reviews, except: [:index, :new]
      resources :contents, only: [:create, :update, :destroy]
      resources :seasons, only: [:create, :destroy, :update]
      resources :episodes, only: [:create, :destroy, :update]
    end
  end
end
