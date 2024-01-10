class Genre < ApplicationRecord
  has_many :items

  validates :name, presence: true

  def self.ransackable_attributes(auth_object = nil)
    %w[name]
  end
end
