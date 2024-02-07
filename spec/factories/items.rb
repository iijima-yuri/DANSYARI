FactoryBot.define do
  factory :item do
    sequence(:name) { |n| "アイテム#{n}" }
    reason_status { "worry" }
    episode_content { "episode_content" }
    reason_content { "reason_content" }
    status { "published" }
    association :user
    association :genre
    item_image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/test.png')) }
  end
end
