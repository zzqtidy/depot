Rails.application.routes.draw do
  # get 'article/index'
  #
  # get 'book/index'

  resources :products  #对应products——controller
  resources :book
  resources :article #对应article——controller
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #root :to=>'book#index'
end
