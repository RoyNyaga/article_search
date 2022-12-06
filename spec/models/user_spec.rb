require 'rails_helper'

RSpec.describe User, type: :model do

  context "when validating presence" do 
    let(:user) { build(:user) }
    context "when email is blank" do 
      it "User email can't be blank" do
        user.email = nil
        user.valid?
        expect(user.errors.full_messages).to include("Email can't be blank") 
      end
    end 

    context "when password is blank" do 
      let(:user) { User.new()}
      it "User password can not be blank" do 
        user.password = nil,
        user.valid?
        expect(user.errors.full_messages).to include("Password can't be blank")
      end 
    end 
  end 

  context "when validating email uniqueness" do 
    let(:user_one) { create(:user) }
    it "user email has already been taken" do 
      user_two = build(:user, email: user_one.email)
      user_two.valid?
      expect(user_two.errors.full_messages).to include("Email has already been taken")
    end 
  end

  context "when validating password confirmation" do
    let(:user) { build(:user) }
    context "when passord matches password_confirmation" do 
      it "user should be valid" do 
        user.password_confirmation = user.password
        expect(user).to be_valid
      end 
    end 
    context "when password does not match password_confirmation" do 
      it "user should not be valid" do 
        user.password_confirmation = "anytypeoftext"
        expect(user).not_to be_valid
      end
    end 
  end 
end 