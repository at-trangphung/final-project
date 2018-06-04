class Category < ApplicationRecord
  has_many :products, dependent: :destroy
  belongs_to :parent, class_name: "Category"
  has_many :children, class_name: "Category", foreign_key: "parent_id"
  validates :name, presence: true, uniqueness: { case_sensitive: false }

  def parent_name
    parent.try(:name)
  end

  def has_parent?
    parent.present?
  end

  def has_children?
    children.exists?
  end
end
