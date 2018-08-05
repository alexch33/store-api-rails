Rails.application.routes.draw do
  post 'user_token' => 'user_token#create'
  post 'users/by_email' => 'users#show_by_email'
  get 'orders/seller' => 'orders#show_by_seller_id'
  get 'orders/client' => 'orders#show_by_client_id'
  resources :charges
  resources :uploads
  resources :users
  resources :categories do
    resources :items
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
