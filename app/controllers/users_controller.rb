class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]
  before_action :authenticate_user, except: [:create]

  # GET /users
  def index
    @users = User.all

    render json: @users
  end

  # GET /users/1
  def show
    render json: @user
  end

  # POST /users/by_email
  def show_by_email
    user = User.where(email: params[:email]).first
    render json: user.to_json( :only => [:id, :nick, :email, :role] )
  end

  # POST /users
  def create
    @user = User.new(user_params)
    if User.where(email: @user.email).present?
      render status: :unprocessable_entity
    elsif @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user && @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:email, :password, :nick, role: [])
    end
end
