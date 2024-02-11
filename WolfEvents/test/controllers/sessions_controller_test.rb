require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get newcreatedestroy" do
    get sessions_newcreatedestroy_url
    assert_response :success
  end
end
