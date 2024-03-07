Rails.application.routes.draw do
  scope :api, defaults: { format: :json } do
    devise_for :users, defaults: { format: :json },
               path: '',
               path_names: {
                 sign_in: 'login',
                 sign_out: 'logout',
                 registration: 'signup'
               },
               controllers: {
                 sessions: 'users/sessions'
               }
  end
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :guesses, only: [:show, :create, :update, :destroy]
    end
  end

  root to: "api/v1/guesses#winners"
end
