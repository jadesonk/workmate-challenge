require 'test_helper'

class ShiftsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get shifts_create_url
    assert_response :success
  end

  test "should get clock_out" do
    get shifts_clock_out_url
    assert_response :success
  end

end
