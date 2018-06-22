class OrderServices
  attr_reader :params, :flash

  def initialize(params, flash)
    @params = params
    @flash  = flash
  end

  def find_order
    return if @order
    @order = Transaction.find_by(id: params[:order_id])
  end

  def load_list_order
    return if @orders 
    @orders = Transaction.all
  end

  def update_order
    status = params[:status].to_i
    if (check_status status) && (@order.update_attribute :status, status)
      flash[:success] =  "update_success"
    else
      flash[:danger] =  "update_failed"
    end
  end
  
  def check_status status
    array = [1,2]
    true if array.include? status
  end
end  
