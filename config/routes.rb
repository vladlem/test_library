Rails.application.routes.draw do
  mount Rswag::Ui::Engine => 'api/docs'
  mount Rswag::Api::Engine => 'api/docs'

  namespace :api do
    namespace :admin do
      resources :users
      resources :books
    end

    namespace :clent do
      resources :books, only: [:index, :show, :update, :create]
    end
  end

  post '/auth/login', to: 'authentication#login'
  get '/*a', to: 'application#not_found'
end
