class MessagesController < ApplicationController
  before_action :authenticate_user

  before_action do
    @conversation = Conversation.find(params[:conversation_id])
  end

  def index
    @messages = @conversation.messages

    @messages.where("user_id != ? AND read = ?", current_user.id, false).update_all(read: true)

    @message = @conversation.messages.new

    render json: @messages
  end

  def create
    @message = @conversation.messages.new(message_params)
    @message.user = current_user
    @message.user_id = current_user.id

    if @message.save
      render json: @message
    end
  end

  private
  def message_params
    params.require(:message).permit(:body, :user_id)
  end
end