require 'test_helper'

class ApplicationAssignmentsControllerTest < ActionController::TestCase
  setup do
    @application_assignment = application_assignments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:application_assignments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create application_assignment" do
    assert_difference('ApplicationAssignment.count') do
      post :create, application_assignment: { favorite: @application_assignment.favorite, is_bookmark: @application_assignment.is_bookmark, loginid: @application_assignment.loginid, position: @application_assignment.position }
    end

    assert_redirected_to application_assignment_path(assigns(:application_assignment))
  end

  test "should show application_assignment" do
    get :show, id: @application_assignment
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @application_assignment
    assert_response :success
  end

  test "should update application_assignment" do
    put :update, id: @application_assignment, application_assignment: { favorite: @application_assignment.favorite, is_bookmark: @application_assignment.is_bookmark, loginid: @application_assignment.loginid, position: @application_assignment.position }
    assert_redirected_to application_assignment_path(assigns(:application_assignment))
  end

  test "should destroy application_assignment" do
    assert_difference('ApplicationAssignment.count', -1) do
      delete :destroy, id: @application_assignment
    end

    assert_redirected_to application_assignments_path
  end
end
