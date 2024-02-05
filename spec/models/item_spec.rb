require 'rails_helper'

RSpec.describe Item, type: :model do
  context '必須項目が入力されている場合' do
    it '有効であること' do
      item = build(:item)
      expect(item).to be_valid
    end
  end

  describe 'name' do
    context '名前が空欄の場合' do
      it '無効であること' do
        item = build(:item, name: nil)
        expect(item).to be_invalid
        expect(item.errors[:name]).to include('を入力してください')
      end
    end
  end

  describe 'episode_content' do
    context 'episode_contentが空欄の場合' do
      it '無効であること' do
        item = build(:item, episode_content: nil)
        expect(item).to be_invalid
        expect(item.errors[:episode_content]).to include('を入力してください')
      end
    end
  end

  describe 'reason_content' do
    context 'reason_contentが空欄の場合' do
      it '無効であること' do
        item = build(:item, reason_content: nil)
        expect(item).to be_invalid
        expect(item.errors[:reason_content]).to include('を入力してください')
      end
    end
  end
end
