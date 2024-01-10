class Tag < ApplicationRecord
  has_many :item_tags, dependent: :destroy
  has_many :items, through: :item_tags

  validates :name, presence: true, length: { maximum: 50 }

  def self.ransackable_attributes(auth_object = nil)
    %w[name]
  end
end
