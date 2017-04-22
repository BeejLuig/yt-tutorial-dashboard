Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do

      # /api/v1/users
      resources :users, only: [:create]

      # /api/v1/auth
      post '/auth', to: "auth#login"
      post '/auth/refresh', to: "auth#refresh"

      # /api/v1/playlists
      resources :playlists, only: [:index, :create, :show] do

        post '/reset_videos', to: 'videos#reset_videos'
      # /api/v1/playlists/:id/videos
        resources :videos, only: [:index]
      end

      # /api/v1/videos/:id/complete
      post '/videos/:id/complete', to: 'videos#complete'
    end
  end

end
