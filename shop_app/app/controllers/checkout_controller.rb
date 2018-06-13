class CheckoutController < BaseController
  layout 'customer'

  def create
    @customer = Customer.new(customer_params)
    @receiver = Receiver.new(receiver_params)
    if logged_in?
      @customer.user_id = @service_user.current_user.id
    end

    if @customer.save && @receiver.save
      @transaction = Transaction.new
      @transaction.customer_id = @customer.id
      @transaction.receiver_id = @receiver.id
      @transaction.amount = @total
      @transaction.created = Time.now

      hours_delivery = params[:transaction][:transaction][:hours]
      minutes_delivery = params[:transaction][:transaction][:minutes]
      if ( hours_delivery.blank? && minutes_delivery.blank? )
        @transaction.delivery_time = Time.zone.now
      else
        @transaction.delivery_time = Time.zone.now + hours_delivery.to_i.hours + minutes_delivery.to_i.minutes
      end
    end
    
    if @transaction.save
      @order_items.each do |order_detail|
        order_detail.transaction_id = @transaction.id
        order_detail.save
      end
    end

    session[:transaction_id] = @transaction.id
    session[:shopping_cart] = []
    redirect_to thanks_for_order_path
  end

  def new
    @transaction = Transaction.new
  end

  private

    def customer_params
      params.require(:transaction)[:customer]
            .permit(
              :first_name, :last_name, :email, :company, :address, :address_deliver, :phone
            )
    end

    def receiver_params
      params.require(:transaction)[:receiver]
            .permit(
              :first_name, :last_name, :email, :company, :address, :address_deliver, :phone
            )
    end
end
