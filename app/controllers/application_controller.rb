class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  private
    # 定义私有表示只有控制器中可以访问，不会像行为方法那样呗调用
    # 回话保存，判断session中是否有，如果没有，新建后将cart的id放于回话中
    def current_cart
      Cart.find(session[:cart_id])
    rescue ActiveRecord::RecordNotFound
      cart=Cart.create
      session[:cart_id]=cart.id
      cart
    end
end
