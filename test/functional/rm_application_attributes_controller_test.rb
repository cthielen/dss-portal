require 'test_helper'

class RmApplicationAttributesControllerTest < ActionController::TestCase
  setup do
    @rm_application_attribute = rm_application_attributes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:rm_application_attributes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create rm_application_attribute" do
    assert_difference('RmApplicationAttribute.count') do
      post :create, rm_application_attribute: { description: @rm_application_attribute.description, name: @rm_application_attribute.name, url: @rm_application_attribute.url }
    end

    assert_redirected_to rm_application_attribute_path(assigns(:rm_application_attribute))
  end

  test "should show rm_application_attribute" do
    get :show, id: @rm_application_attribute
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @rm_application_attribute
    assert_response :success
  end

  test "should update rm_application_attribute" do
    put :update, id: @rm_application_attribute, rm_application_attribute: { description: @rm_application_attribute.description, name: @rm_application_attribute.name, url: @rm_application_attribute.url }
    assert_redirected_to rm_application_attribute_path(assigns(:rm_application_attribute))
  end

  test "should destroy rm_application_attribute" do
    assert_difference('RmApplicationAttribute.count', -1) do
      delete :destroy, id: @rm_application_attribute
    end

    assert_redirected_to rm_application_attributes_path
  end
end
