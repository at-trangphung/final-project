class Type < ApplicationRecord
  has_many :productoptions
  has_many :products, through: :productoptions
end
