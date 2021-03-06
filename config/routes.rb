# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users,
             skip: %i[sessions registrations],
             controllers: {
               passwords: 'users/passwords',
               confirmations: 'users/confirmations'
             }
  devise_scope :user do
    get :login, to: 'users/sessions#new', as: :new_user_session
    post :login, to: 'users/sessions#create', as: :user_session
    delete :logout, to: 'users/sessions#destroy', as: :destroy_user_session

    get :signup, to: 'users/registrations#new', as: :new_user_registration
    scope :users do
      get    :cancel, to: 'users/registrations#cancel',  as: :cancel_user_registration
      get    :edit,   to: 'users/registrations#edit',    as: :edit_user_registration
      patch  :/,      to: 'users/registrations#update',  as: :user_registration
      put    :/,      to: 'users/registrations#update'
      post   :/,      to: 'users/registrations#create'
    end
  end

  root 'root#index'

  get '/:id', to: 'posts#show', as: :post, constraints: { id: /\d+/ }
  get '/posts/:id',
      to: redirect('/%{id}', status: 301),
      as: :modify_post,
      constraints: { id: /\d+/ }
  resources :posts, except: [:show] do
    resources :likes, shallow: true, only: %i[create destroy]
  end

  resources :comments, only: %i[create edit update destroy]

  resources :users, only: [:show]
  get :users, to: redirect('/user', status: 301)
  resources :user, only: [] do
    collection do
      get :/, action: :show
      get :edit
      put :update
      patch :update

      resource :image, only: %i[show update], controller: 'users/image'
    end
  end

  resources :information, only: %i[index show]

  # Admin Page
  resources :admin, only: [:index]
  namespace :admin do
    resources :information
    resources :static_page, except: [:show]
    resources :tags
    resource :dump, only: [:show]
  end

  # Static Page
  ActiveSupport.on_load(:after_initialize) do
    Rails.application.routes.append do
      match '*path', controller: :static_page, action: :show, via: :get
    end
  end
end
