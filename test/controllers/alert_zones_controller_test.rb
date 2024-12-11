require "test_helper"

class AlertZonesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @alert_zone = alert_zones(:one)
  end

  test "should get index" do
    get alert_zones_url, as: :json
    assert_response :success
  end

  test "should create alert_zone" do
    assert_difference("AlertZone.count") do
      post alert_zones_url, params: { alert_zone: { alert_id: @alert_zone.alert_id, geometry: @alert_zone.geometry, name: @alert_zone.name } }, as: :json
    end

    assert_response :created
  end

  test "should show alert_zone" do
    get alert_zone_url(@alert_zone), as: :json
    assert_response :success
  end

  test "should update alert_zone" do
    patch alert_zone_url(@alert_zone), params: { alert_zone: { alert_id: @alert_zone.alert_id, geometry: @alert_zone.geometry, name: @alert_zone.name } }, as: :json
    assert_response :success
  end

  test "should destroy alert_zone" do
    assert_difference("AlertZone.count", -1) do
      delete alert_zone_url(@alert_zone), as: :json
    end

    assert_response :no_content
  end
end
