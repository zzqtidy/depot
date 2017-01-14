class Product < ApplicationRecord
  #default_scope：default_scope ：order => 'title' #<rails4版本
  default_scope {order (:title)} #默认范围函数，作用于该模型的所有查询，此处定义所有的查询按title排序(rails4+版本)
  #validate columns is not null and exits
  has_many :line_items
  # 此处定义了一个hook（勾子）方法【对象在生命周期的某个地方，rails自动调用的方法】
  # 在删除之前调用 ensure_not_referenced_by_any_line_item
  before_destroy :ensure_not_referenced_by_any_line_item
  validates :title,:description,:image_url,:presence => true
  validates :price,:numericality => {:greater_than_or_equal_to => 0.01}

  private
  def ensure_not_referenced_by_any_line_item
    if line_items.empty?
      return true
    else
      errors.add(:base,'Line Items Present')
    end
  end
end
