require "test_helper"

class AlertsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @alert = alerts(:one)
  end

  test "should get index" do
    get alerts_url, as: :json
    assert_response :success
  end

  test "should create alert" do
    assert_difference("Alert.count") do
      post alerts_url, params: { alert: { area_desc: @alert.area_desc, description: @alert.description, effective: @alert.effective, expires: @alert.expires, headline: @alert.headline, instruction: @alert.instruction, location_id: @alert.location_id, severity: @alert.severity } }, as: :json
    end

    assert_response :created
  end

  test "should show alert" do
    get alert_url(@alert), as: :json
    assert_response :success
  end

  test "should update alert" do
    patch alert_url(@alert), params: { alert: { area_desc: @alert.area_desc, description: @alert.description, effective: @alert.effective, expires: @alert.expires, headline: @alert.headline, instruction: @alert.instruction, location_id: @alert.location_id, severity: @alert.severity } }, as: :json
    assert_response :success
  end

  test "should destroy alert" do
    assert_difference("Alert.count", -1) do
      delete alert_url(@alert), as: :json
    end

    assert_response :no_content
  end
end
