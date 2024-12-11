module WeatherForecast
	require 'faraday'

	class AlertsByStateService
		def initialize(state)
			@state = state
		end
		
		def call
			response = Faraday.get("https://api.weather.gov/alerts/active/area/" + @state )

			#puts "Status => #{response.status}"
			#puts "Headers => #{response.headers}"
			#puts "Body => #{response.body}"

			severe_levels = ["Severe", "Extreme"]

			if response.success?
				json_body = JSON.parse(response.body)

				json_body['features'].filter_map do |feature|
					if severe_levels.include?feature['properties']['severity']  
						extract_alert_details_as_array(feature['properties'])
					end
				end
			else
				Rails.logger.warn "API request failed with status #{response.status}"
				return nil
			end
		end

		def extract_alert_details_as_array(alert)
			{
				area_desc: alert['areaDesc'],
				headline: alert['headline'],
				description: alert['description'],
				instruction: alert['instruction'],
				effective: alert['effective'],
				expires: alert['expires'],
				severity: alert['severity'],
				zones: alert['geocode']['UGC']
			}
		end
	end
end