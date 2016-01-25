require 'test_helper'

class TreatmentsControllerTest < ActionController::TestCase
  def setup
    @admin = users(:erin)
    @nonadmin = users(:aeryn)
  end

  test "admins can see index of treatments" do
    log_in_as @admin
    get :index
    assert_response :success
  end

  test "non-admins can not see index of treatments" do
    log_in_as @nonadmin
    get :index
    assert_redirected_to root_url
  end

  test "anonymous users can not see index of treatments" do
    get :index
    assert_redirected_to login_url
  end
end
