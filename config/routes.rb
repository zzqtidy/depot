Rails.application.routes.draw do
  get 'book/index'

  resources :products
  resources :book
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root :to=>'book#index'
end
