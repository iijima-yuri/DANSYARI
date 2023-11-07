class Item < ApplicationRecord
  belongs_to :user

  validates :name, presence: true, length: { maximum: 255 }
  validates :episode_content, presence: true, length: { maximum: 65_535 }
  validates :reason_content, presence: true, length: { maximum: 65_535 }
end
