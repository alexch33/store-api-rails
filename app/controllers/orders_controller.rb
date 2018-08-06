class OrdersController < ApplicationController
  before_action :authenticate_user

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
    order_id = params[:id]
    item_id = params[:item_id]
    new_status = params[:status]

    order = Order.where(id: order_id).first
    order_items = order.order_items
    order_items.find { |item| item[:item_id] === item_id }.merge!('item_status' => new_status)

    if order.update(order_items: order_items)
      p "order updated SUCCEFULLY*************************************************"
      if order_items.find {|item| item[:item_status] === 'ACCEPTED'}.size === order_items.size
        order.update(:order_status => 'ACCEPTED')
        p "order closed............................................"
      end

      render json: order
    else

      render status: :unprocessable_entity
    end
  end
end
