class Product < ApplicationRecord
  belongs_to :category
  has_many :orders
  has_many :transactions, through: :orders
  validates :name, presence: true
  validates :price, presence: true, numericality: true
  validates :quantity, presence: true, numericality: {only_integer: true}
end
