class Product < ApplicationRecord
  belongs_to :category
  validates :name, presence: true
  validates :price, presence: true, numericality: true
  mount_uploader :image_link, ProductUploader

  has_many :product_options
  has_many :sizes, through: :product_options
  has_many :types, through: :product_options

end
