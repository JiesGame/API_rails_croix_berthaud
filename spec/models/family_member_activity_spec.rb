require 'rails_helper'

RSpec.describe FamilyMemberActivity, type: :model do
 
  before(:each) do 
    @user = User.create(email:"test@test.com", password:"password", password_confirmation: "password")
    @family_member = FamilyMember.create(firstname:"John", lastname:"Doe", birthdate:"27-10-1986",phonenumber:'0620202020', adresse:"20, rue des Pins 75006 Paris", user_id:@user.id)
    @activity = Activity.create(name:"Poterie", price:135, period:2023)
    @family_member_activity = FamilyMemberActivity.create(family_member_id:@family_member.id, activity_id:@activity.id)
  end

  context "validation" do
    it "is valid with valid attributes" do
      expect(@family_member_activity).to be_a(FamilyMemberActivity)
      expect(@family_member_activity).to be_valid
    end

    it "should be destroyed" do
      @family_member_activity.destroy
      expect(FamilyMemberActivity.find_by(id:1)).to eq(nil)
    end
  end
end