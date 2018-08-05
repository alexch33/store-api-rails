class ChargesController < ApplicationController
  before_action :authenticate_user

  def create
    # Amount in cents
    @amount = params[:amount]
    customer = Stripe::Customer.create(
        :email => params[:stripeEmail],
        :source  => params[:stripeToken][:id]
    )
    charge = Stripe::Charge.create(
        :customer    => customer.id,
        :amount      => @amount,
        :description => 'Rails Stripe customer',
        :currency    => 'usd'
    )
    if charge[:status]
      render json: charge
    end

  rescue Stripe::CardError => e
    p "error", e.message
    render json: { error: e.message }
  end
end
