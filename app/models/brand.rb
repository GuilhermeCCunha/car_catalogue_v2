class Brand < ApplicationRecord
  has_many :cars, :dependent => :destroy

  validates :brand_name, presence: true, length: 2..28, uniqueness: true
end
