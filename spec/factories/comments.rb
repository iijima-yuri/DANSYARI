FactoryBot.define do
  factory :comment do
    body { 'Comment' }
    association :user
    association :item
  end
end
