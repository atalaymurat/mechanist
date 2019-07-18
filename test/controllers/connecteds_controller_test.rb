require 'test_helper'

class ConnectedsControllerTest < ActionDispatch::IntegrationTest
  test "should get destroy" do
    get connecteds_destroy_url
    assert_response :success
  end

end
