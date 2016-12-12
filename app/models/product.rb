class Product < ApplicationRecord
  #default_scope：default_scope ：order => 'title' #<rails4版本
  default_scope {order (:title)} #默认范围函数，作用于该模型的所有查询，此处定义所有的查询按title排序(rails4+版本)
  #validate columns is not null and exits
  validates :title,:description,:image_url,:presence => true
  validates :price,:numericality => {:greater_than_or_equal_to => 0.01}
end
