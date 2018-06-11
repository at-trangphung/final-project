class Article < ApplicationRecord
  has_many :comments
  mount_uploader :image_link, ProductUploader
end
