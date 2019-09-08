FactoryBot.define do
  #一般チャット
  factory :sample_message, class: Message do
    chat {'sample'}
  end
end
