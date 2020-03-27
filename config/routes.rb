Rails.application.routes.draw do
  devise_for :users
  resources :games do
    resources :reviews
  end
  get '/search' => 'games#search', :as => 'search_page'
  root 'games#index'
end
