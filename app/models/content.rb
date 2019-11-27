class Content < ApplicationRecord
  belongs_to :order
  belongs_to :first_course, class_name: "Item"
  belongs_to :main_course, class_name: "Item"
  belongs_to :drink, class_name: "Item"
end
