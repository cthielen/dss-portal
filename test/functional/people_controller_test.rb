require 'test_helper'

class PeopleControllerTest < ActionController::TestCase
  begin
    setup do
      @person = people(:one)
      CASClient::Frameworks::Rails::Filter.fake("okadri")
    end

    test "should update person, and return valid JSON" do
      put :update, format: :json, id: @person, person: { loginid: @person.loginid, name: @person.name }
      assigns(:person)
      assert_response :success
      body = JSON.parse(@response.body)
      assert_not_nil body["id"]
      assert_not_nil body["loginid"]
      assert_not_nil body["application_assignments"]
    end
    
  end
end
