class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :item
  belongs_to :commentable, polymorphic: true

  has_many :notifications, dependent: :destroy

  validates :body, presence: true, length: { maximum: 56_535 }
end
