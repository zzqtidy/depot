class Cart < ApplicationRecord
  # 一个购物车有多个在线商品，购物车删除之后，对应的加到购物车中的在线商品也要清空，也就是
  # 清空line_item中与之关联的数据
  has_many :line_item,:dependent => :destroy
  def add_product(product_id)
    current_item=line_item.find_by_product_id(product_id);
    if current_item
      current_item.quantity +=1;
    else
      current_item=line_item.build(:product_id=>product_id);
    end
    return current_item;
  end
end
