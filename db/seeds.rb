# アドミンユーザー
User.find_or_create_by!(email: "ad@com") do |user|
  user.name = "Ad"
  user.email = "ad@com"
  user.password = "aaaaaa"
  user.password_confirmation = "aaaaaa"
  user.admin = true
  user.activated = true
  user.activated_at = Time.zone.now
end

#　有効モブユーザー25名
25.times do |n|
  name  = Faker::Name.name
  email = "cpa#{n+1}@com"
  password = "aaaaaa"
  User.find_or_create_by!(email: "cpa#{n+1}@com") do |user|
    user.name = name
    user.email = email
    user.password = password
    user.password_confirmation = password
    user.activated = true
    user.activated_at = Time.zone.now
  end
end

#　無効モブユーザー25名
25.times do |n|
  name  = Faker::Name.name
  email = "cpn#{n+1}@com"
  password = "aaaaaa"
  User.find_or_create_by!(email: "cpn#{n+1}@com") do |user|
    user.name = name
    user.email = email
    user.password = password
    user.password_confirmation = password
    user.activated = false
  end
end