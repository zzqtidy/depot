class Cart < ApplicationRecord
  # 一个购物车有多个在线商品，购物车删除之后，对应的加到购物车中的在线商品也要清空，也就是
  # 清空line_item中与之关联的数据
  has_many :line_item,:dependent => :destroy
end
