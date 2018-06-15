# module Services
  class CheckoutServices
    attr_reader :params

    def initialize(params)
      @params       = params
      # @current_user = current_user
    end

    def create_transaction
      @transaction = Transaction.new
      @transaction.created = Time.now
      hours_delivery = params[:transaction][:transaction][:hours]
      minutes_delivery = params[:transaction][:transaction][:minutes]
      if ( hours_delivery.blank? && minutes_delivery.blank? )
        @transaction.delivery_time = Time.zone.now
      else
        @transaction.delivery_time = Time.zone.now + hours_delivery.to_i.hours 
                                                   + minutes_delivery.to_i.minutes
      end
      @transaction
    end

    def create_new_user
      @new_user = User.new
      @new_user.password = "Thuanhieu123"
      @new_user.first_name = customer_params[:first_name]
      @new_user.last_name = customer_params[:last_name]
      @new_user.email = customer_params[:email]
      @new_user.address = customer_params[:address]
      @new_user.address_deliver = customer_params[:address_deliver]
      @new_user.company = customer_params[:company]
      @new_user.phone = customer_params[:phone]
      @new_user.save!
    end

    def customer_params
      params.require(:transaction)[:customer]
            .permit(
              :first_name, :last_name, :email, :company, :address, :address_deliver, :phone
            )
    end
  end
# end
