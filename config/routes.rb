# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :teams do
    get :download_logo, on: :member
    post :create_or_update, on: :collection
  end

  resources :managers, only: %i[index show create update]
end
