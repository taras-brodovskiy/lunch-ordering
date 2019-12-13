class Item < ApplicationRecord
  before_save :fix_name_format, :fix_kind_format
  
  mount_uploader :photo, PhotoUploader

  validates :name,  presence: true, length: { maximum: 50 }, 
                    uniqueness: { case_sensitive: false }
  VALID_PRICE_FORMAT = /\A\d{1,2}\.\d{1,2}\z/  
  validates :price, presence: true, numericality: { greater_than: 0.0, less_than: 100.0 }
  validates :kind,  presence: true, inclusion: { in: %w(first main drink) }
  validate  :photo_size

  private

    # Downcases the kind
    def fix_name_format
      name.capitalize!
    end

    # Downcases the kind
    def fix_kind_format
      kind.downcase!
    end

    # Validates the size of an uploaded picture.
    def photo_size
      if photo.size > 5.megabytes
        errors.add(:photo, "should be less than 5MB")
      end
    end
end
