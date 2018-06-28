class CommentProduct < ApplicationRecord
  belongs_to :product, class_name: 'Product', foreign_key: "product_id"
  belongs_to :user, class_name: 'User', foreign_key: "user_id"
end
