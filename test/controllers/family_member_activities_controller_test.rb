require "test_helper"

class FamilyMemberActivitiesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get family_member_activities_new_url
    assert_response :success
  end
end
