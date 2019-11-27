class Item < ApplicationRecord
  
  before_save :fix_name_format, :fix_kind_format
    
  validates :name,  presence: true, length: { maximum: 50 }, 
                    uniqueness: { case_sensitive: false }
  VALID_PRICE_FORMAT = /\A\d{1,2}\.\d{1,2}\z/  
  validates :price, presence: true, numericality: { greater_than: 0.0, less_than: 100.0 }
  validates :kind,  presence: true, inclusion: { in: %w(first main drink) }

  private

    def fix_name_format
      name.capitalize!
    end

    def fix_kind_format
      kind.downcase!
    end
end
