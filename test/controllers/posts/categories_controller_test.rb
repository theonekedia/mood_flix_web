require 'test_helper'

class Posts::CategoriesControllerTest < ActionController::TestCase
  setup do
    @posts_category = posts_categories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:posts_categories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create posts_category" do
    assert_difference('Posts::Category.count') do
      post :create, posts_category: { name: @posts_category.name }
    end

    assert_redirected_to posts_category_path(assigns(:posts_category))
  end

  test "should show posts_category" do
    get :show, id: @posts_category
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @posts_category
    assert_response :success
  end

  test "should update posts_category" do
    patch :update, id: @posts_category, posts_category: { name: @posts_category.name }
    assert_redirected_to posts_category_path(assigns(:posts_category))
  end

  test "should destroy posts_category" do
    assert_difference('Posts::Category.count', -1) do
      delete :destroy, id: @posts_category
    end

    assert_redirected_to posts_categories_path
  end
end
