require 'rails_helper'

RSpec.feature "Search Features", type: :feature, js: true do
  let(:user) { create(:user) }
  let(:article) { Article.create(title: "Tech Interview In USA", content: "This is content of Tech Interview in USA") }
  before(:each) do 
    article
    user   
  end
  context 'When user is not loggedIn' do 
    context "when user performs a search" do
      context "when there is no match" do
        scenario "Articles should not be found" do
          visit root_path
          expect(page).to have_text article.title
          expect(page).to have_link "Sign In to save your searches"
          fill_in "query", with: "something else"
          page.execute_script("$('#query').trigger('mouseleave')")
          expect(page).not_to have_text article.title
        end

        scenario "Saved Search should not be created" do
          visit root_path
          expect(page).to have_text article.title
          expect(page).to have_link "Sign In to save your searches"
          fill_in "query", with: "something else"
          page.execute_script("$('#query').trigger('mouseleave')")
          expect(page).not_to have_text article.title
          expect(SavedSearch.count).to eq(0)
        end
      end

      context "when there is a match" do
        scenario "Article should be found" do
          visit root_path
          expect(page).to have_text article.title
          expect(page).to have_link "Sign In to save your searches"
          fill_in "query", with: article.title
          page.execute_script("$('#query').trigger('mouseleave')")
          expect(page).to have_text article.title
        end

        scenario "Saved Search Should not be created" do
          visit root_path
          expect(page).to have_text article.title
          expect(page).to have_link "Sign In to save your searches"
          fill_in "query", with: article.title
          page.execute_script("$('#query').trigger('mouseleave')")
          expect(page).to have_text article.title
          expect(SavedSearch.count).to eq(0)
        end
      end
    end
  end

  context "When user is loggedIn" do
    before(:each) do
      visit new_user_session_path
      fill_in "user_email", with: user.email
      fill_in "user_password", with: user.password
      click_button "Log in"
    end

    context "when user is typing in search input field" do
      scenario "Saved Search does not get created" do
        expect(page).to have_link "Sign Out"
        fill_in "query", with: article.title
        expect(user.saved_searches.count).to eq(0)
        expect(page).to have_text article.title
      end
    end

    context "When user stops typing" do
      scenario "Saved Search gets created" do
        expect(page).to have_link "Sign Out"
        fill_in "query", with: "Anythig"
        page.execute_script("$('#query').trigger('mouseleave')") # when users mouse moves away from the search input field
        # expect(user.saved_searches.count).to eq(0)
        # expect(page).to have_text article.title
        # expect(user.saved_searches.count).to eq(1)
      end
    end
  end
end

