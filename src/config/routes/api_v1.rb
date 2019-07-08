namespace :api, defaults: { format: 'json' } do
  namespace :v1 do
    get 'swagger' => redirect('/swagger/dist/index.html?url=/api/v1/docs')
    get 'docs', to: 'doc#index'
    post 'login' => 'auth#authenticate_user'
    resources :user_log_types, only: :index
    resources :users do
      resources :user_logs
    end
  end
end
