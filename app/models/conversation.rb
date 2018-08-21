class Conversation < ApplicationRecord
  belongs_to :sender, class_name: 'User', foreign_key: 'sender_id'
  belongs_to :receiver, class_name: 'User', foreign_key: 'receiver_id'
  has_many :messages, dependent: :destroy

  validates_uniqueness_of :sender_id, scope: :receiver_id

  scope :between, -> (sender_id,receiver_id) do
    where("(conversations.sender_id = ? AND conversations.receiver_id = ?) OR (conversations.receiver_id = ? AND conversations.sender_id = ?)", sender_id, receiver_id, sender_id, receiver_id)
  end

  def recipient(current_user)
    self.sender_id == current_user.id ? self.receiver : self.sender
  end

  def unread_message_count(current_user_id)
    self.messages.where("user_id != ? AND read = ?", current_user_id, false).count
  end

  def as_json(options = {})
    reciever_nick = User.where(id: self.receiver_id).first.nick
    sender_nick = User.where(id: self.sender_id).first.nick
    unread_count = unread_message_count options[:current_user_id]
    options = options.merge({ receiver_nick: reciever_nick, sender_nick: sender_nick, unread_count: unread_count })
    super.as_json.merge(options)
  end

end
