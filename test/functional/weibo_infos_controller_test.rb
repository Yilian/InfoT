require 'test_helper'

class WeiboInfosControllerTest < ActionController::TestCase
  setup do
    @weibo_info = weibo_infos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:weibo_infos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create weibo_info" do
    assert_difference('WeiboInfo.count') do
      post :create, :weibo_info => @weibo_info.attributes
    end

    assert_redirected_to weibo_info_path(assigns(:weibo_info))
  end

  test "should show weibo_info" do
    get :show, :id => @weibo_info.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @weibo_info.to_param
    assert_response :success
  end

  test "should update weibo_info" do
    put :update, :id => @weibo_info.to_param, :weibo_info => @weibo_info.attributes
    assert_redirected_to weibo_info_path(assigns(:weibo_info))
  end

  test "should destroy weibo_info" do
    assert_difference('WeiboInfo.count', -1) do
      delete :destroy, :id => @weibo_info.to_param
    end

    assert_redirected_to weibo_infos_path
  end
end
