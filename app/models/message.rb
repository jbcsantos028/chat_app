class Message < ApplicationRecord
  belongs_to :user
  belongs_to :channel
  after_create_commit { broadcast_append_to channel }
  before_create :confirm_participant

  def confirm_participant
    return unless channel.is_private
    
    is_participant = Participant.where(user_id: user.id, channel_id: channel.id).first
    throw :abort unless is_participant
  end
end
