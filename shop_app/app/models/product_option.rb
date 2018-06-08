class ProductOption < ApplicationRecord
  belongs_to :size
  belongs_to :type
  belongs_to :product
end
