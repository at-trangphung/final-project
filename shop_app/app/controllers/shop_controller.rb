class ShopController < BaseController
  before_action :logged_in?
  def index
    @categories = Category.all.where(parent_id: 0)
  end

  private
end
