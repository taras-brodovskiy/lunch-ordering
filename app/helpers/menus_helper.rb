module MenusHelper
  def last_menu
    @last_menu = Menu.last
  end

  def all_menu_dates
    menus = Menu.all
    unless menus
      return nil
    end
    dates = []
    menus.each do |menu|
      unless dates.index(menu.menu_date)
        dates << menu.menu_date
      end
    end
    dates
  end
end
