require 'rails_helper'

RSpec.describe SearchController, type: :controller do
  describe "GET search" do
    before(:each) do 
      Article.create(title: "Tech Interview In USA", content: "This is content of Tech Interview in USA")
    end

    context "When user is not loggedIn" do
      context "when there is a match" do
        before(:each) do 
          get :search, params: { query: "tech interview", save: "false", format: :js }, xhr: true
        end
        it "should return article" do         
          expect(assigns(:articles).count).to eq(1)
        end

        it "saved search should not be created" do
          expect(SavedSearch.count).to eq(0)
        end
      end

      context "when there is no match" do
        before(:each) do 
          get :search, params: { query: "Something else", save: "false", format: :js }, xhr: true
        end
        it "should not return an article" do
          expect(assigns(:articles).count).to eq(0)
        end

        it "saved search shouldn't be crerated" do
          expect(SavedSearch.count).to eq(0)
        end
      end
    end

    context "When user is loggedIn" do
      let(:user) { create(:user) }
      before(:each) do
        sign_in user # the sign_in method is made available by config.include Devise::Test::ControllerHelpers, type: :controller, check inside the rails_helper file for more information
      end
      context "When user is typing in search input field" do
        context "when there is a match" do
          it "should return article" do
            get :search, params: { query: "tech interview", save: "false", format: :js }, xhr: true
            expect(assigns(:articles).count).to eq(1)
          end
        end

        context "when there is no match" do
          it "should not return an article" do
            get :search, params: { query: "Anything", save: "false", format: :js }, xhr: true
            expect(assigns(:articles).count).to eq(0)
          end
        end
      end

      context "When user stops typing and mouseout the search input field" do
        context "when saved search does't exist" do
          it "should create a saved search for the user with search parameters" do
            get :search, params: { query: "Tech Interview In", save: "true", format: :js }, xhr: true
            expect(user.saved_searches.count).to eq(1)
            expect(user.saved_searches.first.search_params).to eq("Tech Interview In".downcase)
          end
        end
      end

      context "when saved search already exist for user" do
        it "should not crerate saved search" do
          SavedSearch.create(search_params: "Tech Interview In".downcase, user: user)
          expect(SavedSearch.count).to eq(1)
          get :search, params: { query: "Tech Interview In", save: "true", format: :js }, xhr: true
          expect(SavedSearch.count).to eq(1)
        end
      end
    end
  end
end

