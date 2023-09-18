Rails.application.routes.draw do
  devise_for :users,
             controllers: {
               sessions: 'users/sessions',
               registrations: 'users/registrations'
             }
  get '/member-data', to: 'members#show'
  resources :articles do
    resources :comments
  end
  resources :users
  post 'password/forgot', to: 'password#forgot'
  put 'password/reset/:token', to: 'password#reset'
  put 'password/update', to: 'password#update'
  post 'users/destroy_with_password', to: "users#destroy_with_password"

  scope '/checkout' do
    post 'create', to: 'checkout#create', as: 'checkout_create'
    get 'success', to: 'checkout#success', as: 'checkout_success'
    get 'cancel', to: 'checkout#cancel', as: 'checkout_cancel'
  end

  namespace :admin do
    resources :users
    resources :articles, except: [:show]
    get 'articles/:category', to: 'articles#index_admin'
    delete 'user_destroy_by_admin/:id', to: 'users#user_destroy_by_admin'
  end
end
