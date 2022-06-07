Rails.application.routes.default_url_options[:host] = 'localhost:3000'

Rails.application.routes.draw do

  namespace :api, defaults: { format: :json } do
    resources :articles do
      resources :comments, only: %i[create update edit delete index]
    end
  end

  namespace :api, defaults: { format: :json } do
    resources :users, only: %w[show]
  end

  
  devise_for :users,
    defaults: { format: :json },
    path: '',
    path_names: {
      sign_in: 'api/login',
      sign_out: 'api/logout',
      registration: 'api/signup'
    },
    controllers: {
      sessions: 'sessions',
      registrations: 'registrations'
    }

end
