FactoryBot.define do
  factory :entry do
    association :user
    association :chat_room
  end
end
