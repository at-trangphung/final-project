class Shop::FavoritesController < BaseController
  before_action :load_service

  def new
    @favorite = Favorite.new
  end

  def create
    @service_favorite.create_favorite
  end
 
  def destroy
    @service_favorite.destroy_favorite
  end

  private
  def load_service
    @service_favorite = FavoritesServices.new(params, @service_user.current_user)
  end
end
