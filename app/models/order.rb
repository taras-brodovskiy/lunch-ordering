class Order < ApplicationRecord
  belongs_to :user

  has_one :content, dependent: :destroy
  has_one :first_course, through: :content
  has_one :main_course, through: :content
  has_one :drink, through: :content

  validates :price, presence: true
  validate :order_correctness

  def order_correctness
    unless first_course && main_course && drink
      errors.add(:completeness, "must contain 3 elements")
      return
    end 
    differ = price - (first_course.price + main_course.price + drink.price)
    unless differ === BigDecimal("0")
      errors.add(:price, "can't differ from the total cost of items")
    end 
  end
end
