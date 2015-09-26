require 'test_helper'

class DeviceRegistrationsControllerTest < ActionController::TestCase
  setup do
    @device_registration = device_registrations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:device_registrations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create device_registration" do
    assert_difference('DeviceRegistration.count') do
      post :create, device_registration: { device_id: @device_registration.device_id, email: @device_registration.email, platform: @device_registration.platform, registration_key: @device_registration.registration_key, user_id: @device_registration.user_id }
    end

    assert_redirected_to device_registration_path(assigns(:device_registration))
  end

  test "should show device_registration" do
    get :show, id: @device_registration
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @device_registration
    assert_response :success
  end

  test "should update device_registration" do
    patch :update, id: @device_registration, device_registration: { device_id: @device_registration.device_id, email: @device_registration.email, platform: @device_registration.platform, registration_key: @device_registration.registration_key, user_id: @device_registration.user_id }
    assert_redirected_to device_registration_path(assigns(:device_registration))
  end

  test "should destroy device_registration" do
    assert_difference('DeviceRegistration.count', -1) do
      delete :destroy, id: @device_registration
    end

    assert_redirected_to device_registrations_path
  end
end
