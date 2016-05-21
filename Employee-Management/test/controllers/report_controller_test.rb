require 'test_helper'

class ReportControllerTest < ActionController::TestCase
  test "should get utilization" do
    get :utilization
    assert_response :success
  end

  test "should get revenue" do
    get :revenue
    assert_response :success
  end

end
