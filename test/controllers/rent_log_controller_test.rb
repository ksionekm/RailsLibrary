require 'test_helper'

class RentLogControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get rent_log_index_url
    assert_response :success
  end

end
