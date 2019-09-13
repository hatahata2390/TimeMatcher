class LikeRelationship < ApplicationRecord
# Validation
  validates :like_sender_id,    presence: true, uniqueness: { scope: :like_receiver_id }
  validates :like_receiver_id,  presence: true, uniqueness: { scope: :like_sender_id }
    
# Relation
  belongs_to :like_sender,   class_name: "User"
  belongs_to :like_receiver, class_name: "User"
end
