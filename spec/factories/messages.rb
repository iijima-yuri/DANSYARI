FactoryBot.define do
  factory :message do
    message { "Message" }
    association :user
  end
end
