Rails.application.routes.draw do
  scope :api, defaults: { format: :json } do
    devise_for :users
  end
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :guesses
    end
  end

  root to: "api/v1/guesses#index"
end
