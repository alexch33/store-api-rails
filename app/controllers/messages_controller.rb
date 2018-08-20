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
      msg_json = @message.as_json
      ConversationsChannel.broadcast_to(@conversation.receiver, {message: msg_json, type: :object})
      ConversationsChannel.broadcast_to(@conversation.sender, {message: msg_json, type: :object})

      render json: @message
    end
  end

  private
  def message_params
    params.require(:message).permit(:body, :user_id, :conversation_id)
  end
end