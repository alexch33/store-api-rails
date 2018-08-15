class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :update, :destroy]
  before_action :authenticate_user, except: [:index]
  before_action :set_user_id, except: [:index, :create]

  # GET /comments?:item_id
  def index
    @comments = Comment.where(item_id: params[:item_id])

    render json: @comments
  end

  # GET /comments/1
  def show
    render json: @comment
  end

  # POST /comments
  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @comment.author = current_user.nick

    if @comment.save
      render json: @comment, status: :created, location: @comment
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /comments/1
  def update
    if @comment.update(comment_params)
      render json: @comment
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /comments/1
  def destroy
    @comment.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def comment_params
      params.require(:comment).permit(:user_id, :item_id, :body)
    end

  def set_user_id
    @comment.user_id = current_user.id
  end
end
