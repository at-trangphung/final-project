class Comment < ApplicationRecord
  belongs_to :acticle
  belongs_to :user
end
