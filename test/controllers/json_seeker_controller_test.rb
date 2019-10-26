require 'test_helper'

class JsonSeekerControllerTest < ActionDispatch::IntegrationTest
  test "should get seek" do
    get json_seeker_seek_url
    assert_response :success
  end

end
