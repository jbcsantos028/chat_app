class Channel < ApplicationRecord
  validates_uniqueness_of :name
  scope :public_channels, -> { where(is_private: false) }
  after_create_commit { broadcast_if_public }
  has_many :messages
  has_many :participants, dependent: :destroy

  def broadcast_if_public
    broadcast_append_to "channels" unless self.is_private
  end

  def self.create_private_channel(users, channel_name)
    single_channel = Channel.create(name: channel_name, is_private: true)
    users.each do |user|
      Participant.create(user_id: user.id, channel_id: single_channel.id)
    end
    single_channel
  end
end
