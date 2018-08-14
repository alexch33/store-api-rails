class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :user

  validates_presence_of :body, :conversation_id, :user_id

  def as_json(options = {})
    if self.id
      options = options.merge({ nick: self.user.nick , time: message_time })
      super.as_json.merge(options)
    else
      super.as_json({})
    end
  end

  private
  def message_time
    created_at.strftime("%d/%m/%y at %l:%M %p")
  end
end
