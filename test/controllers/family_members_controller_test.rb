require "test_helper"

class FamilyMembersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @family_member = family_members(:one)
  end

  test "should get index" do
    get family_members_url, as: :json
    assert_response :success
  end

  test "should create family_member" do
    assert_difference("FamilyMember.count") do
      post family_members_url, params: { family_member: { adresse: @family_member.adresse, birthdate: @family_member.birthdate, firstname: @family_member.firstname, homephonenumber: @family_member.homephonenumber, lastname: @family_member.lastname, legaltutorfirstname: @family_member.legaltutorfirstname, legaltutorlastname: @family_member.legaltutorlastname, phonenumber: @family_member.phonenumber, user_id: @family_member.user_id } }, as: :json
    end

    assert_response :created
  end

  test "should show family_member" do
    get family_member_url(@family_member), as: :json
    assert_response :success
  end

  test "should update family_member" do
    patch family_member_url(@family_member), params: { family_member: { adresse: @family_member.adresse, birthdate: @family_member.birthdate, firstname: @family_member.firstname, homephonenumber: @family_member.homephonenumber, lastname: @family_member.lastname, legaltutorfirstname: @family_member.legaltutorfirstname, legaltutorlastname: @family_member.legaltutorlastname, phonenumber: @family_member.phonenumber, user_id: @family_member.user_id } }, as: :json
    assert_response :success
  end

  test "should destroy family_member" do
    assert_difference("FamilyMember.count", -1) do
      delete family_member_url(@family_member), as: :json
    end

    assert_response :no_content
  end
end
