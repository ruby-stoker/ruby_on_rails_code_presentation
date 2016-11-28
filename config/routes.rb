Rails.application.routes.draw do
  constraints(Constraints::BackofficeSubdomain) do
    scope module: :backoffice, as: :backoffice, subdomain: :backoffice do
      root to: 'dashboards#show'
      get '/', to: 'dashboards#show', as: 'dashboard'
      post '/set_moderator/:id', to: 'users#set_moderator', as: 'set_moderator'
      resources :users, except: [:destroy]
      resources :clubs, except: [:destroy]
    end

    get :sign_in, to: 'sessions#new'
    post :sign_in, to: 'sessions#create'
    get :sign_out, to: 'sessions#destroy'
  end

  get :find_club, to: 'home#find_club'
  post :find_club, to: 'home#list_clubs'

  root to: 'home#index'

  get :branding, to: 'branding#index' if Rails.env.development?
end
