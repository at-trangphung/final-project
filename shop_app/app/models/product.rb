class Product < ApplicationRecord

  has_many :productoptions
  has_many :sizes, through: :productoptions
  has_many :types, through: :productoptions

end
