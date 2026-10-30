class Car < ApplicationRecord
  belongs_to :brand

  validates :description, presence: true, length: 2..60
  validates :year, numericality: true, length: { is: 4 }
end
