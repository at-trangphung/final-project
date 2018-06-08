class Product < ApplicationRecord
  has_many :product_options
  has_many :sizes, through: :product_options
  has_many :types, through: :product_options
  has_many :orders
  has_many :transactions, through: :orders
  mount_uploader :image_link, ProductUploader

end
