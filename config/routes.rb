Rails.application.routes.draw do
  get 'messages/index'
  get 'conversations/index'
  post 'user_token' => 'user_token#create'
  post 'users/by_email' => 'users#show_by_email'
  get 'orders/search' => 'orders#search' # must have parametr "for_client=(true or false)"
  get 'orders/:id/:item_id' => 'orders#order_item_status_update'
  get 'order_details/:id' => 'orders#get_order_details'
  get 'items/search' => 'items#search'
  get 'uploads/item/:item_id' => 'uploads#index_item_upload'
  get 'items/:id' => 'items#index_show'

  resources :charges
  resources :comments
  resources :uploads
  resources :users
  resources :categories do
    resources :items
  end
  resources :conversations, only: [:index, :create] do
    resources :messages, only: [:index, :create]
  end

  mount ActionCable.server => '/cable'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
