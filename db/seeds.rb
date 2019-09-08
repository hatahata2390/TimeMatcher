#　有効男性モブユーザー25名
25.times do |n|
  name  = Faker::Name.name
  email = "cpam#{n+1}@com"
  password = "aaaaaa"
  comment = "I'm a #{n+1} male user.."
  User.find_or_create_by!(email: "cpa#{n+1}@com") do |user|
    user.gender = 'male'
    user.name = name
    user.email = email
    user.password = password
    user.password_confirmation = password
    user.activated = true
    user.activated_at = Time.zone.now
    user.comment = comment
  end
end

#　有効女性モブユーザー25名
25.times do |n|
  name  = Faker::Name.name
  email = "cpaf#{n+1}@com"
  password = "aaaaaa"
  comment = "I'm a #{n+1} female user.."
  User.find_or_create_by!(email: "cpa#{n+1}@com") do |user|
    user.gender = 'female'
    user.name = name
    user.email = email
    user.password = password
    user.password_confirmation = password
    user.activated = true
    user.activated_at = Time.zone.now
    user.comment = comment
  end
end

#　無効男性モブユーザー5名
5.times do |n|
  name  = Faker::Name.name
  email = "cpnm#{n+1}@com"
  password = "aaaaaa"
  comment = "I'm a negative #{n+1} male user.."
  User.find_or_create_by!(email: "cpn#{n+1}@com") do |user|
    user.gender = 'male'
    user.name = name
    user.email = email
    user.password = password
    user.password_confirmation = password
    user.activated = false
    user.comment = comment
  end
end

#　無効女性モブユーザー5名
5.times do |n|
  name  = Faker::Name.name
  email = "cpnf#{n+1}@com"
  password = "aaaaaa"
  comment = "I'm a negative #{n+1} female user.."
  User.find_or_create_by!(email: "cpn#{n+1}@com") do |user|
    user.gender = 'female'
    user.name = name
    user.email = email
    user.password = password
    user.password_confirmation = password
    user.activated = false
    user.comment = comment
  end
end

# アドミンユーザー
User.find_or_create_by!(email: "ad@com") do |user|
  user.gender = 'male'
  user.name = "Ad"
  user.email = "ad@com"
  user.password = "aaaaaa"
  user.password_confirmation = "aaaaaa"
  user.admin = true
  user.activated = true
  user.activated_at = Time.zone.now
  user.comment = "I'm admin user."
end

# リレーションシップ & ルーム
users = User.all
user  = users.first
like_receivers = users[26..40]
like_senders = users[30..44]
matchers = users[30..40]
like_receivers.each { |like_receiver| user.like(like_receiver) }
like_senders.each { |like_sender| like_sender.like(user) }
matchers.each do |matcher|
  room = Room.new(name: "seed#{matcher.name}")
  room.save
  room.add_user(user)
  room.add_user(matcher) 
end