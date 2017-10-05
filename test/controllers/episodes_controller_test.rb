require 'test_helper'

class EpisodesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get episodes_home_url
    assert_response :success
  end

  test "should get events" do
    get episodes_events_url
    assert_response :success
  end

  test "should get help" do
    get episodes_help_url
    assert_response :success
  end

  test "should get about" do
    get episodes_about_url
    assert_response :success
  end

end
