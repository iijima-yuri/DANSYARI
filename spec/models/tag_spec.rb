require 'rails_helper'

RSpec.describe Tag, type: :model do
  context '名前が空欄の場合' do
    it '無効であること' do
      tag = build(:tag, name: nil)
      expect(tag).to be_invalid
      expect(tag.errors[:name]).to include('を入力してください')
    end
  end
end
