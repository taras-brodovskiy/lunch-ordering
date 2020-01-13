class Menu < ApplicationRecord
  has_many :fillings, dependent:   :destroy
  has_many :items,    through:     :fillings
  
  validates :menu_date, presence: true

  def Menu.add_item_to_today_menu(item)
    menu = Menu.today_menu
    unless menu.item
      menu.items << item
    end
  end

  def Menu.today_menu
    menu = Menu.find_by(menu_date: Date.today)
    unless menu
      menu = Menu.create(menu_date: Date.today)
    end
    menu
  end
end
