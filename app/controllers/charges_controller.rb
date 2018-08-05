class ChargesController < ApplicationController
  before_action :authenticate_user

  def create
    # Amount in cents
    @amount = params[:amount] * 100
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
      if charge[:status] === 'succeeded'
        items = params[:items]
        items_by_sellers_ids = Hash.new
        items.each do |item|
          user_id = item[:user_id]
          if items_by_sellers_ids[user_id].nil?
            items_by_sellers_ids[user_id] = [].push(item)
          else
            items_by_sellers_ids[user_id].push(item)
          end
        end

        items_by_sellers_ids.each do |seller_id, seller_items|
          order_params = ActionController::Parameters.new({order: {
              client_id: current_user.id,
              seller_id: seller_id,
              order_items: [], order_price: 0
          }})
          price_count = 0
          new_order = Order.new(order_params.require(:order).permit(:client_id, :seller_id, :order_price, order_items: []))
          seller_items.each do |item|
            if item[:id] && item[:price]
              new_order.order_items << {
                  item_id: item[:id],
                  price: item[:price],
                  quantity: item[:quantity ] || 1,
                  total_price: item[:totalPrice] || item[:price],
                  item_status: 'CLIENT_PENDING'
              }
              price_count += item[:totalPrice] || item[:price]
            end
          end
          new_order[:order_price] = price_count

          if new_order.save
            # TODO push notification to seller
            p '************************************************************'
            p 'new_order saved SUCCESS: ', new_order
            p '************************************************************'
          else
            # TODO push to client that order fails
            p '#############################################################'
            p 'new order saving FAILED: ', new_order
            p '#############################################################'
          end
        end
      render json: charge
    end

  rescue Stripe::CardError => e
    p "error", e.message
    render json: { error: e.message }
  end
end
