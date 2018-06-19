class Product < ApplicationRecord
  belongs_to :category
  validates :name, presence: true, uniqueness: { case_sensitive: false }

  has_many :product_options
  has_many :sizes, through: :product_options
  has_many :types, through: :product_options
end
