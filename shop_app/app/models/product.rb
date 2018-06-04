class Product < ApplicationRecord
  has_many :product_options
  has_many :sizes, through: :product_options
  has_many :types, through: :product_options
  mount_uploader :image_link, ProductUploader

end
