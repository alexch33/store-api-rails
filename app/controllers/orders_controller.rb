class OrdersController < ApplicationController
  before_action :authenticate_user

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
end
