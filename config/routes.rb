Rails.application.routes.draw do
  devise_for :users, skip: [:sessions, :registrations]
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

  root 'roots#index'

  resources :comments, only: [:create, :edit, :destroy]
  resources :users, only: [:index, :show]

  get '/:id', to: 'posts#show', as: :post
  resources :posts, except: [:show]
end
