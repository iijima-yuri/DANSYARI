require 'rails_helper'

RSpec.describe Contact, type: :model do

  context 'すべてのフィールドが有効な場合' do
    it '有効であること' do
      contact = build(:contact)
      expect(contact).to be_valid
    end
  end

  describe 'name' do
    context '名前が空欄の場合' do
      it '無効であること' do
        contact = build(:contact, name: nil)
        expect(contact).to be_invalid
        expect(contact.errors[:name]).to include('を入力してください')
      end
    end
  end

  describe 'email' do
    context 'emailが空欄の場合' do
      it '無効であること' do
        contact = build(:contact, email: nil)
        expect(contact).to be_invalid
        expect(contact.errors[:email]).to include('を入力してください')
      end
    end
  end

  describe '問い合わせ内容' do
    context '問い合わせ内容が空欄の場合' do
      it '無効であること' do
        contact = build(:contact, content: nil)
        expect(contact).to be_invalid
        expect(contact.errors[:content]).to include('を入力してください')
      end
    end
  end
end
