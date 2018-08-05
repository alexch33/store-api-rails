class OrdersController < ApplicationController
  before_action :authenticate_user

  def show_by_client_id
    @orders_by_clent = Order.where(client_id: current_user.id)
    render json: @orders_by_clent
  end

  def show_by_seller_id
    @orders_by_seller = Order.where(seller_id: current_user.id)
    render json: @orders_by_seller
  end
end
