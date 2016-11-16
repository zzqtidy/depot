class Product < ApplicationRecord
  #validate columns is not null and exits
  validates :title,:description,:image_url,:presence => true
  validates :price,:numericality => {:greater_than_or_equal_to => 0.01}
end
