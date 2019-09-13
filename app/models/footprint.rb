class Footprint < ApplicationRecord
# Validation
  validates :stepper_id,     presence: true, uniqueness: { scope: :stepped_on }
  validates :stepped_on_id,  presence: true
  
# Relation
  belongs_to :stepper,    class_name: "User"
  belongs_to :stepped_on, class_name: "User"
end
