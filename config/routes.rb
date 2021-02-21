Rails.application.routes.draw do
  root 'home#index'

  devise_for :recruiters, controllers: { registrations: 'recruiter/registrations' }

  resources :companies
  resources :jobs do
    post 'disable', on: :member
    post 'enable', on: :member
  end

end
