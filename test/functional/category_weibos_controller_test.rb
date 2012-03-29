require 'test_helper'

class CategoryWeibosControllerTest < ActionController::TestCase
  setup do
    @category_weibo = category_weibos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:category_weibos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create category_weibo" do
    assert_difference('CategoryWeibo.count') do
      post :create, :category_weibo => @category_weibo.attributes
    end

    assert_redirected_to category_weibo_path(assigns(:category_weibo))
  end

  test "should show category_weibo" do
    get :show, :id => @category_weibo.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @category_weibo.to_param
    assert_response :success
  end

  test "should update category_weibo" do
    put :update, :id => @category_weibo.to_param, :category_weibo => @category_weibo.attributes
    assert_redirected_to category_weibo_path(assigns(:category_weibo))
  end

  test "should destroy category_weibo" do
    assert_difference('CategoryWeibo.count', -1) do
      delete :destroy, :id => @category_weibo.to_param
    end

    assert_redirected_to category_weibos_path
  end
end
