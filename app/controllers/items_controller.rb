class ItemsController < ApplicationController
  before_action only: [:show, :update, :destroy]
  before_action :authenticate_user, only: [:update, :destroy, :create]
  # GET /category_id/items
  def index
    page_number, per_page = params[:page], params[:per_page]

    @category = Category.where({category: params[:category_id]}).first
    if @category.nil?
      render status: :not_found
    elsif page_number && per_page
      @items_category = Item.where({category_id: @category.id}).page(page_number).per(per_page)
      render json: @items_category.as_json.push(total_pages: @items_category.total_pages)
    elsif
      page_number
      @items_category = Item.where({category_id: @category.id}).page(page_number)
      render json: @items_category.as_json.push(total_pages: @items_category.total_pages)
    else
      @items_category = Item.where({category_id: @category.id})
      render json: @items_category.as_json.push(total_pages: 1)
    end
  end

  # GET /category_id/items/1
  def show
    @item_category_index = select_item(params[:category_id], params[:id])

    if @item_category_index.nil?
      render status: :not_found
    else
      render json: @item_category_index
    end
  end

  # POST /category_id/items
  def create
    @item = Item.new(item_params)

    if @item.save
      render json: @item, status: :created
    else
      render json: @item.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /category_id/items/1
  def update
    @item = select_item(params[:category_id], params[:id])
    if @item.nil?
      render status: :not_found
    else
      if @item.owner?(current_user)
        if @item.update(item_params)
          render json: @item
        else
          render json: @item.errors, status: :unprocessable_entity
        end
      else
        render status: :method_not_allowed
      end
    end


  end

  # DELETE /category_id/items/1
  def destroy
    @item = select_item(params[:category_id], params[:id])
    if @item.owner?(current_user) || current_user.role.find {|r| /admin|moderator/i =~ r}
      @item.destroy
    else
      render status: :method_not_allowed
    end
  end

  private
    def select_item(category, item_id)
      @category = Category.where({category: category}).first
      @items_category_index = Item.where({category_id: @category.id, id: item_id}).first
    end

    # Only allow a trusted parameter "white list" through.
    def item_params
      params.require(:item).permit(:title, :description, :rating, :price, :category_id, :user_id)
    end
end
