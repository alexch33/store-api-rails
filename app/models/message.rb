class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :user

  validates_presence_of :body, :conversation_id, :user_id

  def as_json(options = {})
    if self.id
      super.as_json.merge(options)
    else
      super.as_json({})
    end
  end
end
