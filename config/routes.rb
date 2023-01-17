Rails.application.routes.draw do
  devise_for :users
  root 'pages#index'

  namespace :api do
    namespace :v1 do
      resources :titles, only: [:index, :show] do
        collection do
          get "/filter/(:query)", action: :index # the genre of the title
        end
      end
    end
  end
end
