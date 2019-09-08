FactoryBot.define do
  factory :favorite do
    owner_user_id { 1 }
    favorite_user_id { 1 }
  end
end
