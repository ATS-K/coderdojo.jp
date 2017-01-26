require 'rails_helper'

RSpec.feature "Blogs", type: :feature do
  describe "GET /news/2016/12/12/new-backend" do
    scenario "Title should be formatted" do
      visit "/news/2016/12/12/new-backend"
      expect(page).to have_title "CoderDojo Japan のバックエンドを更新しました - CoderDojo Japan"
    end
  end
end
