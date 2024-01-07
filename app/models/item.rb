class Item < ApplicationRecord
  mount_uploader :item_image, ItemImageUploader
  belongs_to :user
  belongs_to :genre
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :favorites, dependent: :destroy

  has_many :notifications, dependent: :destroy

  has_many :item_tags, dependent: :destroy
  has_many :tags, through: :item_tags

  


  enum reason_status: { trash: 0, stay: 1, worry: 2 }
  enum status: { published: 0, unpublished: 1 }

  validates :name, presence: true, length: { maximum: 255 }
  validates :episode_content, presence: true, length: { maximum: 65_535 }
  validates :reason_content, presence: true, length: { maximum: 65_535 }

  def favorited?(user)
    favorites.where(user_id: user.id).exists?
  end

  def create_notification_favorite(current_user)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and item_id = ? and action = ? ", current_user.id, user_id, id, 'favorite'])
    return unless temp.blank?

    notification = current_user.active_notifications.new(item_id: id, visited_id: user_id, action: 'favorite')
    notification.checked = true if notification.visitor_id == notification.visited_id

    notification.save if notification.valid?
  end

  def create_notification_comment(current_user, comment_id, item_id)
    item = Item.find(item_id)
    return unless item && current_user != item.user

    save_notification_comment(current_user, comment_id, item.user.id)
  end

  def save_notification_comment(current_user, comment_id, visited_id)
    notification = current_user.active_notifications.new(item_id: id, comment_id:, visited_id:, action: 'comment')
    notification.checked = true if notification.visitor_id == notification.visited_id
    notification.save if notification.valid?
  end

  def save_tags(tags)
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    old_tags = current_tags - tags
    new_tags = tags - current_tags

    old_tags.each do |old_name|
      self.tags.delete Tag.find_by(name: old_name)
    end

    new_tags.each do |new_name|
      tag = Tag.find_or_create_by(name: new_name)
      self.tags << tag
    end
  end
end
