class Favorite < ApplicationRecord
# Validation
  validates :owner_user_id,     presence: true
  validates :favorite_user_id,  presence: true
    
# Relation
  belongs_to :owner_user,    class_name: "User"
  belongs_to :favorite_user, class_name: "User"
end
