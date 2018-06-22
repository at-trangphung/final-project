class OrderServices
  attr_reader :params, :flash

  def initialize(params, flash)
    @params = params
    @flash  = flash
  end

  def load_list_order
    @orders = Transaction.all
  end

  def update_order
    @order = Transaction.find_by(id: params[:id])
    status = params[:status].to_i
    if (check_status status) && (@order.update_attribute :status, status)
      flash[:success] =  "update_success"
      @order.send_check_order_email
    else
      flash[:danger] =  "update_failed"
    end
  end
  
  def check_status status
    array = [1,2]
    true if array.include? status
  end

  def find_order
    Transaction.find_by(id: params[:order_id])
  end

end  
