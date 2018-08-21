class ConversationsChannel < ApplicationCable::Channel
  def subscribed
    jwt = params[:token]
    decoded_token = JWT.decode jwt, Rails.application.secrets.secret_key_base, true, { :algorithm => 'HS256' }
    @current_user = User.where(id: decoded_token[0]['sub']).first

    if @current_user
      stream_for @current_user
      get_users_convs
    end
  end

  def get_users_convs
    conversations = Conversation.where("sender_id = ? OR receiver_id = ?", @current_user.id, @current_user.id)
    options = {current_user_id: @current_user.id}
    convs = conversations.as_json options
    ConversationsChannel.broadcast_to(@current_user, {conversations: convs, type: :array})
  end

  def set_read_true message
    message = Message.where(id: message['id']).first
    unless message.read
      if message.update(read: true)
        json_message = message.as_json @current_user.nick
        ConversationsChannel.broadcast_to(message.conversation.receiver, {message: json_message, type: :object})
        ConversationsChannel.broadcast_to(message.conversation.sender, {message: json_message, type: :object})
      end
    end
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
