Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :breweries, only: [:index, :show]
      resources :venues, only: [:index, :show]
      resources :beers, only: :show
    end
  end

  resources :venues
  resources :beers, except: [:new, :show]
  resources :breweries, except: [:new, :show]

  root 'breweries#index'
end
