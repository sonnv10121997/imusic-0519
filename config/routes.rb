Rails.application.routes.draw do
  devise_for :users, only: :omniauth_callbacks, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    devise_for :users, skip: :omniauth_callbacks
    namespace :admin do
      resources :categories, except: :show
      root "/admin#index"
    end
    post "/rate", to: "rate#create", as: "rate"
    root "home_page#index"
  end
end
