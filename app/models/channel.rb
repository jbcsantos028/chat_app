class Channel < ApplicationRecord
  validates_uniqueness_of :name
  scope :public_channels, -> { where(is_private: false) }
  after_create_commit { broadcast_append_to "channels" }
  has_many :messages
end
