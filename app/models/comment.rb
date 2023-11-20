class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :item

  validates :body, presence: true, length: { maximum: 56_535 }
end
