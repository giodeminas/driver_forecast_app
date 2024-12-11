class AlertDownloadService
    def call
        latest_location = Location.last

        if !latest_location.nil?
            state = WeatherForecast::StateByCoordinatesService.new(latest_location.latitude, latest_location.longitude).call

            latest_location.update(state: state)

            relevant_alerts = WeatherForecast::AlertsByStateService.new(state).call

            if !relevant_alerts.nil?
                relevant_alerts.each do |relevant_alert|
                    alert = Alert.create(
                    location_id: latest_location.id,
                    area_desc: relevant_alert[:area_desc],
                    headline: relevant_alert[:headline],
                    description: relevant_alert[:description],
                    instruction: relevant_alert[:instruction],
                    effective: relevant_alert[:effective],
                    expires: relevant_alert[:expires],
                    severity: relevant_alert[:severity]
                    )

                    relevant_alert[:zones].each do |relevant_zone|
                        geometry = WeatherForecast::PolygonByZoneService.new(relevant_zone).call

                        if !geometry.nil?
                            AlertZone.create(
                                alert_id: alert.id,
                                name: relevant_zone,
                                geometry: geometry
                            )
                        else
                            Rails.logger.warn "Failed to retrieve alert zone details for zone: #{relevant_zone}"
                        end
                    end
                end
            else
                Rails.logger.warn "No alerts for state: #{latest_location.state}"
            end
        else
            Rails.logger.warn "No locations found in the database"
        end
    end
end