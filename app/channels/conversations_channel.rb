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
    options = {current_user: @current_user}
    convs = conversations.as_json options
    ConversationsChannel.broadcast_to(@current_user, {conversations: convs, type: :array})
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
