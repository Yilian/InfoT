require 'test_helper'

class CountsControllerTest < ActionController::TestCase
  setup do
    @count = counts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:counts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create count" do
    assert_difference('Count.count') do
      post :create, :count => @count.attributes
    end

    assert_redirected_to count_path(assigns(:count))
  end

  test "should show count" do
    get :show, :id => @count.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @count.to_param
    assert_response :success
  end

  test "should update count" do
    put :update, :id => @count.to_param, :count => @count.attributes
    assert_redirected_to count_path(assigns(:count))
  end

  test "should destroy count" do
    assert_difference('Count.count', -1) do
      delete :destroy, :id => @count.to_param
    end

    assert_redirected_to counts_path
  end
end
