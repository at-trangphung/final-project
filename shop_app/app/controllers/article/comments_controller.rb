class Article::CommentsController < BaseController
  layout 'customer'

  def new
    @comment = Comment.new
  end

  def create
    @service_comment.create
    article = @service_comment.find_article
    redirect_to article_path(article)
  end

  def destroy
    @service_comment.destroy
    article = @service_comment.find_article
    redirect_to article_path(article)
  end
end
