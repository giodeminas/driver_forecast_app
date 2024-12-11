require "test_helper"

class ParametersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @parameter = parameters(:one)
  end

  test "should get index" do
    get parameters_url, as: :json
    assert_response :success
  end

  test "should create parameter" do
    assert_difference("Parameter.count") do
      post parameters_url, params: { parameter: { key: @parameter.key, value: @parameter.value } }, as: :json
    end

    assert_response :created
  end

  test "should show parameter" do
    get parameter_url(@parameter), as: :json
    assert_response :success
  end

  test "should update parameter" do
    patch parameter_url(@parameter), params: { parameter: { key: @parameter.key, value: @parameter.value } }, as: :json
    assert_response :success
  end

  test "should destroy parameter" do
    assert_difference("Parameter.count", -1) do
      delete parameter_url(@parameter), as: :json
    end

    assert_response :no_content
  end
end
