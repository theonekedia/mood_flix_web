require 'test_helper'

class PostsControllerTest < ActionController::TestCase
  setup do
    @post = posts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:posts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create post" do
    assert_difference('Post.count') do
      post :create, post: { date: @post.date, description: @post.description, location: @post.location, location_lat: @post.location_lat, location_lng: @post.location_lng, max_people: @post.max_people, min_people: @post.min_people, post_status_id: @post.post_status_id, status_id: @post.status_id, user_id: @post.user_id, user_lat: @post.user_lat, user_lng: @post.user_lng }
    end

    assert_redirected_to post_path(assigns(:post))
  end

  test "should show post" do
    get :show, id: @post
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @post
    assert_response :success
  end

  test "should update post" do
    patch :update, id: @post, post: { date: @post.date, description: @post.description, location: @post.location, location_lat: @post.location_lat, location_lng: @post.location_lng, max_people: @post.max_people, min_people: @post.min_people, post_status_id: @post.post_status_id, status_id: @post.status_id, user_id: @post.user_id, user_lat: @post.user_lat, user_lng: @post.user_lng }
    assert_redirected_to post_path(assigns(:post))
  end

  test "should destroy post" do
    assert_difference('Post.count', -1) do
      delete :destroy, id: @post
    end

    assert_redirected_to posts_path
  end
end
