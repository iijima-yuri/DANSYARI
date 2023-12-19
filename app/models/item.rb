class Item < ApplicationRecord
  mount_uploader :item_image, ItemImageUploader
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :favorites, dependent: :destroy

  enum reason_status: { trash: 0, stay: 1, worry: 2 }
  enum status: { published: 0, unpublished: 1 }

  validates :name, presence: true, length: { maximum: 255 }
  validates :episode_content, presence: true, length: { maximum: 65_535 }
  validates :reason_content, presence: true, length: { maximum: 65_535 }

  def favorited?(user)
    favorites.where(user_id: user.id).exists?
  end
end
