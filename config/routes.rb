Rails.application.routes.draw do
  post 'user_token' => 'user_token#create'
  post 'users/by_email' => 'users#show_by_email'
  get 'orders/search' => 'orders#search' # must have parametr "for_client=(true or false)"
  resources :charges
  resources :uploads
  resources :users
  resources :categories do
    resources :items
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
