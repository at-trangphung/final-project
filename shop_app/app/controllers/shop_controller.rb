class ShopController < ApplicationController
  def index
    @categories = Category.all.where(parent_id: 0)
  end
end
