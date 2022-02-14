Rails.application.routes.draw do
  resources :home, only: :show do
    resources :posts, only: [:index, :create]
  end

  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
