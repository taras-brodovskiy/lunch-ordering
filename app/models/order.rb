class Order < ApplicationRecord
  belongs_to :user

  has_one :content, dependent: :destroy
  has_one :first_course, through: :content
  has_one :main_course, through: :content
  has_one :drink, through: :content

  validates :price, presence: true
  validate :actual_price

  def actual_price
    differ = price - (first_course.price + main_course.price + drink.price)
    unless differ === BigDecimal("0")
      errors.add(:price, "can't differ from the total cost of items")
    end 
  end
end
