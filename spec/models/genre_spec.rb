require 'rails_helper'

RSpec.describe Genre, type: :model do
  context '名前が空欄の場合' do
    it '無効であること' do
      genre = build(:genre, name: nil)
      expect(genre).to be_invalid
      expect(genre.errors[:name]).to include('を選択してください')
    end
  end
end
