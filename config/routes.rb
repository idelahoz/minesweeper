Rails.application.routes.draw do
  resources :games, only: [:create] do
    collection do
      post :move
    end
  end
end
