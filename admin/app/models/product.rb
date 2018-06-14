class Product < ApplicationRecord
  belongs_to :category
  validates :name, presence: true
  validates :price, presence: true, numericality: true
  mount_uploader :image_link, ProductUploader
end
