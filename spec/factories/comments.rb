FactoryBot.define do
  factory :comment do
    body { 'Comment' }
    association :user
    association :item
    association :commentable
    association :notification
  end
end
