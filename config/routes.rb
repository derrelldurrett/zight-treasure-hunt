Rails.application.routes.draw do
  devise_for :users
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :guesses
    end
  end

  root to: "api/v1/guesses#index"
end
