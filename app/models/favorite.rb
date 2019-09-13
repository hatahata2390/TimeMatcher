class Favorite < ApplicationRecord
# Validation
  validates :owner_user_id,     presence: true, uniqueness: { scope: :favorite_user_id }
  validates :favorite_user_id,  presence: true
    
# Relation
  belongs_to :owner_user,    class_name: "User"
  belongs_to :favorite_user, class_name: "User"
end
