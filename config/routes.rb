Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/', to: 'home#index'

  resources :books do
    resources :reviews
  end

  resources :authors, only: [:show, :destroy]

end
