require "test_helper"

class CommentsControllerTest < ActionDispatch::IntegrationTest
  test "should get rails" do
    get comments_rails_url
    assert_response :success
  end

  test "should get g" do
    get comments_g_url
    assert_response :success
  end

  test "should get controller" do
    get comments_controller_url
    assert_response :success
  end

  test "should get posts" do
    get comments_posts_url
    assert_response :success
  end

  test "should get rails" do
    get comments_rails_url
    assert_response :success
  end

  test "should get g" do
    get comments_g_url
    assert_response :success
  end

  test "should get controller" do
    get comments_controller_url
    assert_response :success
  end

  test "should get tags" do
    get comments_tags_url
    assert_response :success
  end
end
