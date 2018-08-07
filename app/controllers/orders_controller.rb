class OrdersController < ApplicationController
  before_action :authenticate_user
  CLIENT_WAITING = 'CLIENT_WAITING'
  SELLER_WAITING = 'SELLER_WAITING'
  CLIENT_CONFIRMED = 'CLIENT_CONFIRMED'

  # GET /orders/search?for_client=(true|false)&params1=p1&params2=p2&........
  def search
    search_params = params

    if params[:for_client] === 'true'
      search_params[:client_id] = current_user.id
      permitted_params = search_params.except(:for_client, :controller, :order, :action).permit(:client_id, :order_status, :order_items => [])
      @found_orders = Order.where(permitted_params)
    elsif params[:for_client] === 'false'
      search_params[:seller_id] = current_user.id
      permitted_params = search_params.except(:for_client, :controller, :order, :action).permit(:seller_id, :order_status, :order_items => [])
      @found_orders = Order.where(permitted_params)
    end

    render json: @found_orders
  end

  # GET /orders/:id/:item_id
  def order_item_status_update
    order_id = params[:id].to_i
    item_id = params[:item_id].to_i
    new_status = 'ERROR'

    order = Order.where(id: order_id).first
    order_items = order.order_items

    itt = order_items.find { |item| item['item_id'] === item_id }
    if itt['item_status'] === SELLER_WAITING && order['seller_id'] === current_user.id
      new_status = CLIENT_WAITING
    elsif itt['item_status'] === CLIENT_WAITING && order['client_id'] === current_user.id
      new_status = CLIENT_CONFIRMED
    end
    itt.merge!('item_status' => new_status)

    if order.update(order_items: order_items)
      if order_items.size === 1
        order.update(:order_status => order_items[0]['item_status'])
      else
        if order_items.find {|item| item['item_status'] === order_items[0]['item_status']}.size === order_items.size
          order.update(:order_status => order_items[0]['item_status'])
        end
      end

      render json: order
    else

      render status: :unprocessable_entity
    end
  end
end
