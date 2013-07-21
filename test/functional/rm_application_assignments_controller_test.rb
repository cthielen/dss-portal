require 'test_helper'

class RmApplicationAssignmentsControllerTest < ActionController::TestCase
  setup do
    @rm_application_assignment = rm_application_assignments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:rm_application_assignments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create rm_application_assignment" do
    assert_difference('RmApplicationAssignment.count') do
      post :create, rm_application_assignment: { application_id: @rm_application_assignment.application_id, loginid: @rm_application_assignment.loginid }
    end

    assert_redirected_to rm_application_assignment_path(assigns(:rm_application_assignment))
  end

  test "should show rm_application_assignment" do
    get :show, id: @rm_application_assignment
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @rm_application_assignment
    assert_response :success
  end

  test "should update rm_application_assignment" do
    put :update, id: @rm_application_assignment, rm_application_assignment: { application_id: @rm_application_assignment.application_id, loginid: @rm_application_assignment.loginid }
    assert_redirected_to rm_application_assignment_path(assigns(:rm_application_assignment))
  end

  test "should destroy rm_application_assignment" do
    assert_difference('RmApplicationAssignment.count', -1) do
      delete :destroy, id: @rm_application_assignment
    end

    assert_redirected_to rm_application_assignments_path
  end
end
