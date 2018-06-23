class Admin::DashboardController < AdminController
  def index
    @products     = Product.all.size
    @orders       = Transaction.all.size
    @customers    = Customer.all.size
    @transactions = Transaction.where('created  BETWEEN ? AND ?', 
                                      Time.now-(30*3600*24), Time.now).all
    @total        = 0
    @transactions.each do |order|
      @total += order.amount
    end  
  end

  
end
