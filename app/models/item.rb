class Item < ApplicationRecord
  before_save :fix_name_format, :fix_kind_format
  
  mount_uploader :photo, PhotoUploader

  validates :name,  presence: true, length: { maximum: 50 }, 
                    uniqueness: { case_sensitive: false }
  # VALID_PRICE_FORMAT = /\A\d{1,2}\.\d{1,2}\z/
  validate  :price_format
  validates :kind,  presence: true, inclusion: { in: %w(first main drink) }
  validates :photo, presence: true
  validate  :photo_size

  private

    # Downcases the kind
    def fix_name_format
      name.downcase!
    end

    # Downcases the kind
    def fix_kind_format
      kind.downcase!
    end

    def Item.all_kinds
      ["first", "main", "drink"]
    end

    # Validates the size of an uploaded picture.
    def photo_size
      if photo.size > 5.megabytes
        errors.add(:photo, "should be less than 5MB")
      end
    end

    # Validates the format of price
    def price_format
      zero = BigDecimal("0.0")
      hundred = BigDecimal("100.0")
      if (price <= zero) || (price >= hundred)
        errors.add(:price, "should be greater than 0 and less than 100")
      end
    end
end
