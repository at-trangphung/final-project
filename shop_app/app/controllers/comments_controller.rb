class CommentsController < BaseController
  layout 'customer'

  def new
    @comment = Comment.new
  end

  def create
    @article = Article.find(params[:article_id])
    if comment_params[:content].blank?
      flash[:danger] = "add comment failed"
    else
      @comment = @article.comments.create!(comment_params)
    end
    redirect_to article_path(@article)
  end

  def destroy
    @article = Article.find(params[:article_id])
      @comments = []
      @comments << @article.comments.find(params[:id])
      @comments << @article.comments.find_by(parent_id: params[:id])
      @comments.each do |comment|
        if comment != nil
          comment.destroy
        end  
      end  

    redirect_to article_path(@article)
  end
  
  private

  def comment_params
    params.require(:comment).permit(:content, :parent_id)
    .merge(user_id: @service_user.current_user.id)
  end

end
