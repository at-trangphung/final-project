class CommentServices
  attr_reader :params, :flash

  def initialize(params, flash)
    @params = params
    @flash  = flash
  end

  def load_list_comments
    @comments = Comment.all
  end

  def update_comment
    @comment = find_comment
    status = params[:status].to_i
    if (check_status status) && (@comment.update_attribute :status, status)
      flash[:success] =  "update_success"
    else
      flash[:danger] =  "update_failed"
    end
  end
  
  def check_status status
    array = [1,2]
    true if array.include? status
  end

  def find_comment
    Comment.find_by(id: params[:id])
  end
end  
