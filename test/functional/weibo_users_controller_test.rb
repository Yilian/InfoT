require 'test_helper'

class WeiboUsersControllerTest < ActionController::TestCase
  setup do
    @weibo_user = weibo_users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:weibo_users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create weibo_user" do
    assert_difference('WeiboUser.count') do
      post :create, :weibo_user => @weibo_user.attributes
    end

    assert_redirected_to weibo_user_path(assigns(:weibo_user))
  end

  test "should show weibo_user" do
    get :show, :id => @weibo_user.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @weibo_user.to_param
    assert_response :success
  end

  test "should update weibo_user" do
    put :update, :id => @weibo_user.to_param, :weibo_user => @weibo_user.attributes
    assert_redirected_to weibo_user_path(assigns(:weibo_user))
  end

  test "should destroy weibo_user" do
    assert_difference('WeiboUser.count', -1) do
      delete :destroy, :id => @weibo_user.to_param
    end

    assert_redirected_to weibo_users_path
  end
end
