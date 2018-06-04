class Product < ApplicationRecord

  has_many :product_options
  has_many :sizes, through: :productoptions
  has_many :types, through: :productoptions

end
