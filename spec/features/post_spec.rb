# spec/features/post_spec.rb

require 'rails_helper'

describe 'navigate' do
  before do
    user = User.create!(first_name: "Jon", last_name: "Snow", email: "test2@test.com", password: "asdfasdf", password_confirmation: "asdfasdf")
    login_as(user, :scope => :user)
    visit new_post_path
  end

  describe 'index' do
    it 'can be reached successfully' do
      visit posts_path
      expect(page.status_code).to eq(200)
    end

    it 'has a title of Posts' do
      visit posts_path
      expect(page).to have_content(/Posts/)
    end
  end

  describe 'creation' do
    it 'has a new form that can be reached' do
      expect(page.status_code).to eq(200)
    end

    it 'can be created from new form page' do

      fill_in 'post[date]', with: Date.today
      fill_in 'post[rationale]', with: "some rationale"
      click_on "Save"

      expect(page).to have_content("some rationale")
    end

    it 'will have user associated with it' do
      fill_in 'post[date]', with: Date.today
      fill_in 'post[rationale]', with: "User_Association"
      click_on "Save"

      expect(User.last.posts.last.rationale).to eq("User_Association")
    end
  end

end
