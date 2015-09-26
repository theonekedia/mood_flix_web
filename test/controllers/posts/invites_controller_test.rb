require 'test_helper'

class Posts::InvitesControllerTest < ActionController::TestCase
  setup do
    @posts_invite = posts_invites(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:posts_invites)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create posts_invite" do
    assert_difference('Posts::Invite.count') do
      post :create, posts_invite: { accepted_by: @posts_invite.accepted_by, invite_status_id: @posts_invite.invite_status_id, post_id: @posts_invite.post_id }
    end

    assert_redirected_to posts_invite_path(assigns(:posts_invite))
  end

  test "should show posts_invite" do
    get :show, id: @posts_invite
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @posts_invite
    assert_response :success
  end

  test "should update posts_invite" do
    patch :update, id: @posts_invite, posts_invite: { accepted_by: @posts_invite.accepted_by, invite_status_id: @posts_invite.invite_status_id, post_id: @posts_invite.post_id }
    assert_redirected_to posts_invite_path(assigns(:posts_invite))
  end

  test "should destroy posts_invite" do
    assert_difference('Posts::Invite.count', -1) do
      delete :destroy, id: @posts_invite
    end

    assert_redirected_to posts_invites_path
  end
end
