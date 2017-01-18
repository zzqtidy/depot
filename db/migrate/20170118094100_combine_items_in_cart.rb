class CombineItemsInCart < ActiveRecord::Migration[5.0]
  def self.up
    #   将数据库中的多条信息转化为单挑信息，line_items中的数量合并
    Cart.all.each do |cart|
      # 统计每个商品在购物车中的数量
      sums=cart.line_item.group(:product_id).sum(:quantity);
      sums.each do |product_id,quantity|
        if quantity>1
          cart.line_item.where(:product_id=>product_id).delete_all;
          cart.line_item.create(:product_id=>product_id,:quantity=>quantity);
        end
      end
    end
  end
  def self.down
  #   将line_item中数量大于1的数据拆成数量为1的多行
    LineItem.where("quantity>1").each do |line_item|
      line_item.quantity.times do
        LineItem.create(:product_id=>line_item.product_id,:cart_id=>line_item.cart_id,:quantity=>1)
      end
      line_item.destroy
    end
  end
end
