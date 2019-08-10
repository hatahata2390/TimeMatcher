require 'rails_helper'

describe 'ユーザー管理機能', type: :system do
    describe 'ログイン' do
        before do
            user_a = FactoryBot.create(:user)
        end

        context '未有効化ユーザーでのログイン' do
            before do
                visit login_path
                click_button 'Log in'
            end

            it 'ログイン無効' do
                expect(page).to have_content 'Invalid'
            end
        end
    end
end

