require 'rails_helper'

RSpec.describe FamilyMember, type: :model do
 
  before(:each) do 
    @user = User.create(email:"test@test.com", password:"password", password_confirmation: "password")
    @family_member = FamilyMember.create(firstname:"John", lastname:"Doe", birthdate:"27-10-1986",phonenumber:'0620202020', adresse:"20, rue des Pins 75006 Paris", user_id:@user.id)
  end

  context "validation" do

    it "is valid with valid attributes" do
      expect(@family_member).to be_a(FamilyMember)
      expect(@family_member).to be_valid
    end

    describe "#email" do
      it "should not be valid with only firstname" do
        bad_family_member = FamilyMember.create(firstname: "John")
        expect(bad_family_member).not_to be_valid
        expect(bad_family_member.errors.include?(:lastname)).to eq(true)
        expect(bad_family_member.errors.include?(:birthdate)).to eq(true)
        expect(bad_family_member.errors.include?(:phonenumber)).to eq(true)
        expect(bad_family_member.errors.include?(:adresse)).to eq(true)
      end
    end

    describe "#lastname_empty" do
      it "should not be valid with an empty lastname" do
        bad_family_member = FamilyMember.create(firstname:"John", lastname:"", birthdate:"27-10-1986",phonenumber:'0620202020', adresse:"20, rue des Pins 75006 Paris", user_id:@user.id)
        expect(bad_family_member).not_to be_valid
        expect(bad_family_member.errors.include?(:lastname)).to eq(true)
      end
    end

    describe "verify existing family member" do
      it "should find the existing family member" do
        test_family_member = FamilyMember.find_by(firstname: @family_member.firstname)
        expect(test_family_member).to be_valid
        expect(test_family_member.firstname).to eq("John")
        expect(test_family_member.firstname).to eq(@family_member.firstname)
      end
    end

    describe "destroy family member" do
      it "should destroy the existing family member" do
        @family_member.delete
        expect(FamilyMember.find_by(firstname: @family_member.firstname)).to eq(nil)
      end
    end

    describe "test update family member" do
      it "shouldn't be update" do
        @family_member.update(birthdate:"wrong_birthdate")
        expect(@family_member).not_to be_valid
      end 

      it "should be update" do
        @family_member.update(firstname:"Johnny")
        expect(@family_member).to be_valid
      end
    end

  end
end