require 'test_helper'

class BookmarkAssignmentsControllerTest < ActionController::TestCase
  setup do
    @bookmark_assignment = bookmark_assignments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bookmark_assignments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bookmark_assignment" do
    assert_difference('BookmarkAssignment.count') do
      post :create, bookmark_assignment: { bookmark_id: @bookmark_assignment.bookmark_id, loginid: @bookmark_assignment.loginid }
    end

    assert_redirected_to bookmark_assignment_path(assigns(:bookmark_assignment))
  end

  test "should show bookmark_assignment" do
    get :show, id: @bookmark_assignment
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @bookmark_assignment
    assert_response :success
  end

  test "should update bookmark_assignment" do
    put :update, id: @bookmark_assignment, bookmark_assignment: { bookmark_id: @bookmark_assignment.bookmark_id, loginid: @bookmark_assignment.loginid }
    assert_redirected_to bookmark_assignment_path(assigns(:bookmark_assignment))
  end

  test "should destroy bookmark_assignment" do
    assert_difference('BookmarkAssignment.count', -1) do
      delete :destroy, id: @bookmark_assignment
    end

    assert_redirected_to bookmark_assignments_path
  end
end
