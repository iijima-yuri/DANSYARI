require 'rails_helper'

RSpec.describe "Items", type: :system do
  let(:user) { create(:user) }
  let(:item) { create(:item, user: user) }
  let(:other_item) { create(:item) }

  describe '思い出の品物' do
    describe '思い出の品物一覧' do
      context 'ログイン前' do
        it 'ヘッダーの「品物一覧」から飛べること' do
          visit root_path
          click_link '品物一覧'
          expect(page).to have_current_path(items_path)
        end
      end

      context 'ログイン後' do
        it 'ヘッダーの「品物一覧」から飛べること' do
          login(user)
          click_button 'button'
          click_link '品物一覧'
          expect(page).to have_current_path(items_path)
        end
      end

      context '品物が1件もない場合' do
        it '品物がありませんというメッセージがある' do
          visit items_path
          expect(page).to have_content('品物がありません')
        end
      end

      context '品物が1件以上登録させている場合' do
        it '品物が表示される' do
          item
          visit items_path
          expect(page).to have_content(item.name)
        end
      end
    end

    describe '品物詳細・編集・削除' do
      context 'ログイン前' do
        it '詳細は観れるが編集・削除ボタンなどがない' do
          visit item_path(item)
          expect(page).to have_content(item.name)
          expect(page).not_to have_selector("#button-edit-#{item.id}")
          expect(page).not_to have_selector("#button-delete-#{item.id}")
          expect(current_path).to eq(item_path(item))
        end
      end


      describe 'ログイン後' do
        before { login(user) }
        context '他人の詳細ページ' do
          it '編集ボタン・削除ボタンが表示されないこと' do
            visit item_path(other_item)
            expect(page).to have_current_path(item_path(other_item))
            expect(page).not_to have_selector("#item-#{other_item.id}")
            expect(page).not_to have_selector("#item-#{other_item.id}")
          end
        end

        context '自分の詳細ページ' do
          it '編集ボタン・削除ボタンが表示されること' do
            visit item_path(item)
            expect(page).to have_current_path(item_path(item))
            expect(page).to have_selector("#item-#{item.id}")
            expect(page).to have_selector("#item-#{item.id}")
          end

          it '編集ページに移動できること' do
            visit item_path(item)
            click_link '編集'
            expect(page).to have_current_path(edit_item_path(item))
          end

          it '削除できること' do
            visit item_path(item)
            click_link '削除'
            expect(page).to have_current_path(items_path)
          end
        end
      end
    end
  end


  describe '思い出の品物の作成' do
    context 'ログイン前' do
      it 'ログインページにリダイレクトされる' do
        visit new_item_path
        expect(page).to have_content('ログインしてください')
        expect(current_path).to eq(login_path)
      end
    end

    context 'ログイン後' do
      it '品物投稿ページが見れる' do
        login(user)
        visit new_item_path
        expect(page).to have_current_path(new_item_path)
      end
    end

    context '必須項目が有効な場合' do
      before do
        login(user)
        visit new_item_path
      end

      it '品物が登録できる' do
        fill_in 'item[name]', with: 'テスト'
        attach_file 'item[item_image]', "#{Rails.root}/spec/fixtures/test.png"
        fill_in 'item[episode_content]', with: '家族との思い出'
        choose '捨てた'
        fill_in 'item[reason_content]', with: '古いから'
        fill_in 'item[tag_list]', with: '服'
        select "選択してください", from: 'item[genre_id]'
        choose '公開する'
        click_button '投稿'
        expect(page).to have_content('品物を作成できませんでした')
        expect(current_path).to eq(new_item_path)
      end
    end

    context '必須項目が足りない場合' do
      before do
        login(user)
        visit new_item_path
      end

      it '品物名が空で登録できない' do
        fill_in 'item[name]', with: nil
        attach_file 'item[item_image]', "#{Rails.root}/spec/fixtures/test.png"
        fill_in 'item[episode_content]', with: '家族との思い出'
        choose '捨てた'
        fill_in 'item[reason_content]', with: '古いから'
        fill_in 'item[tag_list]', with: '服'
        select "選択してください", from: 'item[genre_id]'
        choose '公開する'
        click_button '投稿'
        expect(page).to have_content('品物を作成できませんでした')
        expect(current_path).to eq(new_item_path)
      end

      it '画像が空で登録できない' do
        fill_in 'item[name]', with: 'テスト'
        fill_in 'item[episode_content]', with: '家族との思い出'
        choose '捨てた'
        fill_in 'item[reason_content]', with: '古いから'
        fill_in 'item[tag_list]', with: '服'
        select "選択してください", from: 'item[genre_id]'
        choose '公開する'
        click_button '投稿'
        expect(page).to have_content('品物を作成できませんでした')
        expect(current_path).to eq(new_item_path)
      end

      it '思い出エピソードが空で登録できない' do
        fill_in 'item[name]', with: 'テスト'
        attach_file 'item[item_image]', "#{Rails.root}/spec/fixtures/test.png"
        fill_in 'item[episode_content]', with: nil
        choose '捨てた'
        fill_in 'item[reason_content]', with: '古いから'
        fill_in 'item[tag_list]', with: '服'
        select "選択してください", from: 'item[genre_id]'
        choose '公開する'
        click_button '投稿'
        expect(page).to have_content('品物を作成できませんでした')
        expect(current_path).to eq(new_item_path)
      end

      it 'ジャンルが空で登録できない' do
        fill_in 'item[name]', with: 'テスト'
        attach_file 'item[item_image]', "#{Rails.root}/spec/fixtures/test.png"
        fill_in 'item[episode_content]', with: '家族との思い出'
        choose '捨てた'
        fill_in 'item[reason_content]', with: '古いから'
        fill_in 'item[tag_list]', with: '服'
        select nil, from: 'item[genre_id]'
        choose '公開する'
        click_button '投稿'
        expect(page).to have_content('品物を作成できませんでした')
        expect(current_path).to eq(new_item_path)
      end
    end
  end
end
