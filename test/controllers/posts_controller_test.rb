require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  test "should get rails" do
    get posts_rails_url
    assert_response :success
  end

  test "should get g" do
    get posts_g_url
    assert_response :success
  end

  test "should get controller" do
    get posts_controller_url
    assert_response :success
  end

  test "should get tags" do
    get posts_tags_url
    assert_response :success
  end
end
