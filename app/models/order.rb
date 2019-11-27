class Order < ApplicationRecord
  validate :actual_price
  belongs_to :user

  has_one :content, dependent: :destroy
  has_one :first_course, through: :content
  has_one :main_course, through: :content
  has_one :drink, through: :content

  validates :price, presence: true

  def actual_price
    if (first_course.price + main_course.price + drink.price) != price
      errors.add(:order_price, "can't differ from the total cost of items")
    end 
  end
end
