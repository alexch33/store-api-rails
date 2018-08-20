class ConversationsController < ApplicationController
  before_action :authenticate_user

  def index
    @conversations = Conversation.where("sender_id = ? OR receiver_id = ?", current_user.id, current_user.id)
    render json: @conversations
  end

  def create
    sener_id = current_user.id
    if Conversation.between(sener_id, params[:receiver_id]).present?
      @conversation = Conversation.between(sener_id, params[:receiver_id]).first
    else

      @conversation = Conversation.create!({sender_id: sener_id, receiver_id: params[:receiver_id]})
    end

    conv_json = @conversation.as_json
    ConversationsChannel.broadcast_to(@conversation.receiver, {conversation: conv_json, type: :object})
    ConversationsChannel.broadcast_to(@conversation.sender, {conversation: conv_json, type: :object})

    render json: @conversation
  end

  private
  def conversation_params

    params.permit(:sender_id, :receiver_id)
  end
end
