Rails.application.routes.draw do
  devise_for :users, skip: [:sessions, :registrations]
  devise_scope :user do
    get :login, to: 'devise/sessions#new', as: :new_user_session
    post :login, to: 'devise/sessions#create', as: :user_session
    delete :logout, to: 'devise/sessions#destroy', as: :destroy_user_session

    get :signup, to: 'devise/registrations#new', as: :new_user_registration
    scope :users do
      get    :cancel, to: 'devise/registrations#cancel',  as: :cancel_user_registration
      get    :edit,   to: 'devise/registrations#edit',    as: :edit_user_registration
      patch  :/,      to: 'devise/registrations#update',  as: :user_registration
      put    :/,      to: 'devise/registrations#update'
      post   :/,      to: 'devise/registrations#create'
    end
  end

  root 'roots#index'
end
