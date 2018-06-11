class CheckoutController < BaseController
  layout 'customer'
  
  def index
  end

  def create
    @customer = Customer.new(address_params)
  end

  private

    def address_params
      params.permit(:first_name, :last_name, :email, :company, :address, :address_deliver, :phone)
    end

end
