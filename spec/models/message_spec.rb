require 'rails_helper'

RSpec.describe Message, type: :model do
  context 'メッセージが空欄の場合' do
    it '無効であること' do
      message = build(:message, message: nil)
      expect(message).to be_invalid
      expect(message.errors[:message]).to include('を入力してください')
    end
  end
end
