class CheckoutController < BaseController
  layout 'customer'

  def create
    @customer = Customer.new(@service_checkout.customer_params)
    @receiver = Receiver.new(receiver_params)

    if logged_in?
      @customer.user_id = @service_user.current_user.id if @customer.user_id.nil?
      @customer_member = Customer.find_by(user_id: @customer.user_id)
    end

    if @customer_member
      @transaction = @service_checkout.create_transaction
      @transaction.customer_id = @customer_member.id
      @transaction.receiver_id = @receiver.id
      @transaction.amount = @total
    else
      @check_user =  User.find_by(email: @customer.email)

      if @check_user
        @user_customer = Customer.find_by(email: @check_user.email)
        @transaction = @service_checkout.create_transaction
        @transaction.customer_id = @user_customer.id
        @transaction.receiver_id = @receiver.id
        @transaction.amount = @total
      else
        @new_user = @service_checkout.create_new_user
        @customer.save! 
        @transaction = @service_checkout.create_transaction
        @transaction.customer_id = @customer.id
        @transaction.receiver_id = @receiver.id
        @transaction.amount = @total
      end
    end
    
    if @transaction.save!
      @order_items.each do |order_detail|
        order_detail.transaction_id = @transaction.id
        order_detail.save
      end
      if @new_user
        UserMailer.new_user_checkout(@new_user).deliver_now
      end
      @transaction.send_check_order_email
      session[:transaction_id] = @transaction.id
      session[:shopping_cart] = []
      redirect_to thanks_for_order_path
    end
  end

  def new
    @transaction = Transaction.new
  end

  def show
    @order_items = Order.where(transaction_id: params[:id])
    @total_price = Transaction.find_by(id: params[:id]).amount
  end

  private
    def receiver_params
      params.require(:transaction)[:receiver]
            .permit(
              :first_name, :last_name, :email, :company, :address, :address_deliver, :phone
            )
    end
end
