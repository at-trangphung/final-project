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

      # hours_delivery = params[:transaction][:transaction][:hours]
      # minutes_delivery = params[:transaction][:transaction][:minutes]
      # if ( hours_delivery.blank? && minutes_delivery.blank? )
      #   @transaction.delivery_time = Time.zone.now
      # else
      #   @transaction.delivery_time = Time.zone.now + hours_delivery.to_i.hours 
      #                                              + minutes_delivery.to_i.minutes
      # end
    else
      @check_user =  User.find_by(email: @customer.email)

      if @check_user
        @user_customer = Customer.find_by(email: @check_user.email)
        @transaction = @service_checkout.create_transaction
        @transaction.customer_id = @user_customer.id
        @transaction.receiver_id = @receiver.id
        @transaction.amount = @total

        # hours_delivery = params[:transaction][:transaction][:hours]
        # minutes_delivery = params[:transaction][:transaction][:minutes]
        # if ( hours_delivery.blank? && minutes_delivery.blank? )
        #   @transaction.delivery_time = Time.zone.now
        # else
        #   @transaction.delivery_time = Time.zone.now + hours_delivery.to_i.hours + minutes_delivery.to_i.minutes
        # end
      else
        @service_checkout.create_new_user
        # @new_user = User.new
        # @new_user.password = "Thuanhieu123"
        # @new_user.first_name = customer_params[:first_name]
        # @new_user.last_name = customer_params[:last_name]
        # @new_user.email = customer_params[:email]
        # @new_user.address = customer_params[:address]
        # @new_user.address_deliver = customer_params[:address_deliver]
        # @new_user.company = customer_params[:company]
        # @new_user.phone = customer_params[:phone]
        # @new_user.save!
        @customer.save! 
        @transaction = @service_checkout.create_transaction
        @transaction.customer_id = @customer.id
        @transaction.receiver_id = @receiver.id
        @transaction.amount = @total

        # hours_delivery = params[:transaction][:transaction][:hours]
        # minutes_delivery = params[:transaction][:transaction][:minutes]
        # if ( hours_delivery.blank? && minutes_delivery.blank? )
        #   @transaction.delivery_time = Time.zone.now
        # else
        #   @transaction.delivery_time = Time.zone.now + hours_delivery.to_i.hours + minutes_delivery.to_i.minutes
        # end
      end
    end
    
    binding.pry
    if @transaction.save!
      @order_items.each do |order_detail|
        order_detail.transaction_id = @transaction.id
        order_detail.save
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
