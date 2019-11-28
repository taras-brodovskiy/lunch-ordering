class Menu < ApplicationRecord
  has_many :fillings, dependent:   :destroy
  has_many :items,    through:     :fillings
  
  validates :menu_date, presence: true
  validate  :actual_date
  
  private
    def actual_date
      errors.add(:menu_date, "should be today") unless menu_date.today?
    end
end
