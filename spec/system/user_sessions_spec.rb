require 'rails_helper'

RSpec.describe "UserSessions", type: :system do
  let(:user) { create(:user) }

  describe 'ログイン機能' do
    context '成功' do
      it 'メールアドレスとパスワードが合っている場合ログインできる' do
        visit login_path
        fill_in 'email', with: user.email
        fill_in 'password', with: 'password'
        click_button 'ログイン'
        expect(page).to have_content('ログインしました')
        expect(current_path).to eq(items_path)
      end
    end

    context '失敗' do
      it 'メールアドレスが間違っている場合ログインできない' do
        visit login_path
        fill_in 'email', with: 'aaa@example.com'
        fill_in 'password', with: 'password'
        click_button 'ログイン'
        expect(page).to have_content('ログインに失敗しました')
        expect(current_path).to eq(login_path)
      end

      it 'パスワードが間違っている場合ログインできない' do
        visit login_path
        fill_in 'email', with: user.email
        fill_in 'password', with: '123456'
        click_button 'ログイン'
        expect(page).to have_content('ログインに失敗しました')
        expect(current_path).to eq(login_path)
      end
    end
  end

  describe 'ログアウト機能' do
    it 'ログインしてからログアウトできる' do
      visit login_path
      fill_in 'email', with: user.email
      fill_in 'password', with: 'password'
      click_button 'ログイン'
      expect(page).to have_content('ログインしました')
      expect(current_path).to eq(items_path)
      click_button('button')
      click_link('ログアウト')
      expect(page).to have_content('ログアウトしました')
      expect(current_path).to eq(root_path)
    end
  end
end
