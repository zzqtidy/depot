Rails.application.routes.draw do
  get 'store/index'

  # get 'article/index'
  #
  # get 'book/index'

  resources :products  #对应products——controller
  resources :book
  resources :article #对应article——controller
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #root :to=>'book#index'
  # 以下是定义根网址的，as部分是告诉rails创建store_path的变量
  root :to=>'store#index',:as=>'store'
end
