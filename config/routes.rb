require 'sidekiq/web'
Sidekiq::Web.use ActionDispatch::Cookies
Sidekiq::Web.use ActionDispatch::Session::CookieStore, key: "_interslice_session"
Rails.application.routes.draw do

#     constraints lambda { |req| req.path.start_with?('/sidekiq') } do
#     Sidekiq::Web.use ActionDispatch::Cookies
#     Sidekiq::Web.use ActionDispatch::Session::CookieStore, key: '_your_app_session'
#     mount Sidekiq::Web => '/sidekiq'
#   end
  # Health check route for load balancers or uptime monitors
  get "up" => "rails/health#show", as: :rails_health_check
  mount Sidekiq::Web, at: "/sidekiq"
  post 'auth/register', to: 'users#register'
  post 'auth/login', to: 'users#login'
  get 'mo', to: 'users#mo'

    resources :posts, only: [:show, :index, :create, :update, :destroy] do
    resources :comments, only: [:index, :create, :update, :destroy]

    resources :tags, only: [:index, :create, :update, :destroy]
  end
end
