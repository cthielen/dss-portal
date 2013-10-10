require 'test_helper'

class ApplicationAssignmentsControllerTest < ActionController::TestCase
  begin
    setup do
      @application_assignment = application_assignments(:two)
      @cached_application = cached_applications(:two)
      CASClient::Frameworks::Rails::Filter.fake("okadri")
    end

    test "should get current_user in index" do
      get :index
      assert_response :success
      assert_not_nil assigns(:current_user)
    end

    test "current_user should have basic attributes" do
      get :index
      assert_response :success
      assert_not_nil assigns(:current_user).loginid
      assert_not_nil assigns(:current_user).rm_id
    end

    test "should assign id and position for a new application_assignment, and create cached_application" do
      post :create, format: :json, application_assignment: { 
        person_id: @application_assignment.person_id,
        bookmark: @application_assignment.bookmark,
        cached_application_attributes: {
          name: @cached_application.name,
          url: @cached_application.url
        }
      }
      assert_response :success
      body = JSON.parse(@response.body)
      assert_not_nil body["id"]
      assert_not_nil body["position"]
      assert_not_nil body["cached_application"]
    end
    
    test "should update application assignment" do
      put :update, format: :json, id: @application_assignment, application_assignment: { position: 3 }
      assert_equal 3, assigns(:assignment).position
    end
    
    test "should destroy application assignment" do
      assert_difference('ApplicationAssignment.count', -1) do
        delete :destroy, format: :json, id: @application_assignment
      end
    end
    
    test "unauthorized users redirected to CAS" do
      revoke_all_access
      get :index
      assert_response 302
    end
    
    test "should fail to modify another users data" do
      with_user(:one) do
        put :update, format: :json, id: 3, application_assignment: { position: 3 }
        assert_response 403
      end
    end    

  end
end
