require 'rails_helper'

RSpec.describe User, type: :model do
 
  before(:each) do 
    @user = User.create(email:"test@test.com", password:"password", password_confirmation: "password")
  end

  context "validation" do

    it "is valid with valid attributes" do
      expect(@user).to be_a(User)
      expect(@user).to be_valid
    end

    describe "#email" do
      it "should not be valid with only email" do
        bad_user = User.create(email: "test@test.com")
        expect(bad_user).not_to be_valid
        expect(bad_user.errors.include?(:password)).to eq(true)
      end
    end

    describe "#email_empty" do
      it "should not be valid with an empty email" do
        bad_user = User.create(email: "", password:"password", password_confirmation: "password")
        expect(bad_user).not_to be_valid
        expect(bad_user.errors.include?(:email)).to eq(true)
      end
    end

    describe "verify existing user" do
      it "should find the existing user" do
        test_user = User.find_by(email: @user.email)
        expect(test_user).to be_valid
        expect(test_user.email).to eq("test@test.com")
        expect(test_user.email).to eq(@user.email)
      end
    end

    describe "destroy user" do
      it "should destroy the existing user" do
        @user.delete
        expect(User.find_by(email: @user.email)).to eq(nil)
      end
    end

    describe "test user" do
      it "should indicate that the user isn't an admin" do
        expect(@user.is_admin).to eq(false)
      end
    end

    describe "test admin" do
      it "should indicate that the user is an admin" do
        @user.update(is_admin:true)
        expect(@user.is_admin).to eq(true)
      end
    end

    describe "test update user" do
      it "shouldn't be update" do
        @user.update(email:"mailnonfonctionnel")
        expect(@user).not_to be_valid
      end 

      it "should be update" do
        @user.update(email:"lala@gmail.com")
        expect(@user).to be_valid
      end
    end

  end
end