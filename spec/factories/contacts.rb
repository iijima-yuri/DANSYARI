FactoryBot.define do
  factory :contact do
    sequence(:name) { |n| "名前#{n}" }
    sequence(:email) { |n| "test#{n}@example.com" }
    content { "Content" }
  end
end
