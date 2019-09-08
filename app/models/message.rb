class Message < ApplicationRecord
# Validation
  validates :chat,   presence: true

# Relation
  belongs_to :room
end
