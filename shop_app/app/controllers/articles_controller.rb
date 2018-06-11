class ArticlesController < BaseController
  layout 'customer'
  before_action :logged_in?
  def index
    @categories = Category.all.where(parent_id: 0)
    @articles = Article.all.paginate page: params[:page], per_page: 9
  end

  def show
    @article = Article.find(params[:id])
    @comments = Article.find(params[:id]).comments.where(parent_id: 0)
  end

end
