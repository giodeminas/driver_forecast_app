class DangerZoneCheckService
    def call
        latest_location = Location.last

        if !latest_location.nil?
            # Create the point using geography (SRID 4326)
            point = RGeo::Geographic.spherical_factory(srid: 4326).point(latest_location.longitude, latest_location.latitude)

            # Convert both the geometry column and point to geometry for the ST_Contains function
            alert_zone = AlertZone.where("ST_Contains(geometry::geometry, ST_SetSRID(ST_MakePoint(?, ?), 4326)::geometry)", point.x, point.y).first
            
            if alert_zone
                Rails.logger.info "Location is within a danger zone"

                alert = Alert.find(alert_zone.alert_id)

                # If within a danger zone, broadcast the message
                ActionCable.server.broadcast(
                    "danger_zone_channel",
                    { message: "Latest location is within the DANGER ZONE: #{alert.area_desc}" }
                )
            else
                Rails.logger.info "Location is not within any danger zone"
            end
        end
    end
end
    