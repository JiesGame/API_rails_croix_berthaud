Rails.application.routes.draw do
  resources :activities
  devise_for :users,
             controllers: {
               sessions: 'users/sessions',
               registrations: 'users/registrations'
             }
  get '/member-data', to: 'members#show'
  resources :family_members
  resources :family_member_activities
  resources :articles do
    resources :comments, :rating
    match '*path', to: 'comments#options', via: :options
  end
  resources :users
  post 'password/forgot', to: 'password#forgot'
  put 'password/reset/:token', to: 'password#reset'
  put 'password/update', to: 'password#update'
  post 'users/destroy_with_password', to: "users#destroy_with_password"
  get 'articles/category/:category', to: 'articles#index_category'
  get 'articles_all', to: 'articles#index_all_categories'

  scope '/checkout' do
    post 'create', to: 'checkout#create', as: 'checkout_create'
    get 'success', to: 'checkout#success', as: 'checkout_success'
    get 'cancel', to: 'checkout#cancel', as: 'checkout_cancel'
  end

  scope '/inscription_checkout' do
    post 'create', to: 'inscription_checkout#create', as: 'inscription_checkout_create'
    get 'success', to: 'inscription_checkout#success', as: 'inscription_checkout_success'
    get 'cancel', to: 'inscription_checkout#cancel', as: 'inscription_checkout_cancel'
  end

  namespace :admin do
    resources :users
    resources :articles, except: [:show]
    get 'users_with_unvalidated_activities', to: 'users#users_with_unvalidated_activities'
    delete 'user_destroy_by_admin/:id', to: 'users#user_destroy_by_admin'
  end
end