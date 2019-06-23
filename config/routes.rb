Rails.application.routes.draw do
  devise_for :users, only: :omniauth_callbacks, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    devise_for :users, skip: :omniauth_callbacks
    namespace :admin do
      %i(users lyrics tracks albums artists categories).each do |model|
        resources model, except: :show
      end
      get "/hot", to: "hot#index"
      patch "/hot", to: "hot#update"
      root "/admin#index"
    end
    resources :comments, only: %i(show create edit update destroy)
    resources :categories, only: %i(index show)
    resources :artists, only: %i(index show)
    resources :albums, only: :show
    resources :tracks, only: :show
    resources :favourites, only: :index
    get "searches/index"
    post "/favourites", to: "favourites#create"
    delete "/favourites", to: "favourites#destroy"
    post "/play", to: "hit#play"
    post "/rate", to: "rater#create", as: "rate"
    root "home_page#index"
  end
end
