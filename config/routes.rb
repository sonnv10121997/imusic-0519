Rails.application.routes.draw do
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    devise_for :users
    post "/rate", to: "rate#create", as: "rate"
    root "home_page#index"
  end
end
