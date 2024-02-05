require 'rails_helper'

RSpec.describe Comment, type: :model do
  context 'フィールドが有効な場合' do
    it '有効であること' do
      comment = build(:comment)
      expect(comment).to be_valid
    end
  end
end
