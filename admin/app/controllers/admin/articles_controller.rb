  class Admin::ArticlesController < AdminController
    def index
      @articles = Article.all
    end

    def new
      @article = Article.new
    end

    def create
      @article = Article.new article_params
      if @article.save
        flash[:success] = "add successfully"
        redirect_to articles_path
      else
        flash[:danger] = "add failed"
        render :new
      end
    end

    def edit
      @articles = Article.all
      article
    end

    def update
      if article.update(article_params)
        flash[:success] = "update successfully"
        redirect_to articles_path
      else
        flash[:danger] = "update failed"
        render :edit
      end
    end

    def destroy
      if article.destroy!
        flash[:success] = "deleted successfully"
      else
        flash[:danger] = "deleted failed"
      end
      redirect_to articles_path
    end

    private

    def article
      return @article if @article
      @article = Article.find(params[:id])
    end

    def article_params
      params.require(:article).permit :title, :content, :image_link
    end

  end
