class Message < ApplicationRecord
  belongs_to :user
  belongs_to :channel
  after_create_commit { broadcast_append_to channel }
end
