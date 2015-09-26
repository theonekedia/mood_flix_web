require 'test_helper'

class Posts::StatusesControllerTest < ActionController::TestCase
  setup do
    @posts_status = posts_statuses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:posts_statuses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create posts_status" do
    assert_difference('Posts::Status.count') do
      post :create, posts_status: { name: @posts_status.name }
    end

    assert_redirected_to posts_status_path(assigns(:posts_status))
  end

  test "should show posts_status" do
    get :show, id: @posts_status
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @posts_status
    assert_response :success
  end

  test "should update posts_status" do
    patch :update, id: @posts_status, posts_status: { name: @posts_status.name }
    assert_redirected_to posts_status_path(assigns(:posts_status))
  end

  test "should destroy posts_status" do
    assert_difference('Posts::Status.count', -1) do
      delete :destroy, id: @posts_status
    end

    assert_redirected_to posts_statuses_path
  end
end
