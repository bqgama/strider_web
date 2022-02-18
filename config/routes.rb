Rails.application.routes.draw do
  resources :home, only: :show do
    resources :posts, only: [:index, :create]
  end

  resources :users, only: :show
end
