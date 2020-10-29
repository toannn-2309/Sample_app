Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#home"

    resources :users
    resources :account_activations, only: :edit
    resources :password_resets, expect: %i(index show destroy)
    resources :microposts, only: %i(create destroy)

    get "help", to: "static_pages#help"
    get "about", to: "static_pages#about"
    get "contact", to: "static_pages#contact"
    get "math", to: "static_pages#math"
    get "signup", to: "users#new"
    get "login", to: "sessions#new"
    post "login", to: "sessions#create"
    delete "logout", to: "sessions#destroy"
  end
end
