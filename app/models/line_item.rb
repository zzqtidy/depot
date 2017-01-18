class LineItem < ApplicationRecord
  # 一个商品对应关系是依赖于product和cart的
  belongs_to :product
  belongs_to :cart
  def total_price
    quantity*product.price
  end
end
