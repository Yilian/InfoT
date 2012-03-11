require 'test_helper'

class OauthInfosControllerTest < ActionController::TestCase
  setup do
    @oauth_info = oauth_infos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:oauth_infos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create oauth_info" do
    assert_difference('OauthInfo.count') do
      post :create, :oauth_info => @oauth_info.attributes
    end

    assert_redirected_to oauth_info_path(assigns(:oauth_info))
  end

  test "should show oauth_info" do
    get :show, :id => @oauth_info.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @oauth_info.to_param
    assert_response :success
  end

  test "should update oauth_info" do
    put :update, :id => @oauth_info.to_param, :oauth_info => @oauth_info.attributes
    assert_redirected_to oauth_info_path(assigns(:oauth_info))
  end

  test "should destroy oauth_info" do
    assert_difference('OauthInfo.count', -1) do
      delete :destroy, :id => @oauth_info.to_param
    end

    assert_redirected_to oauth_infos_path
  end
end
