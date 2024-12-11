module WeatherForecast
	require 'faraday'

	class StateByCoordinatesService
		def initialize(latitude, longitude)
			@latitude = latitude.to_f.round(4).to_s
			@longitude = longitude.to_f.round(4).to_s
		end

		def call
			response = Faraday.get("https://api.weather.gov/points/" + @latitude + "%2C" + @longitude )

			#puts "Status => #{response.status}"
			#puts "Headers => #{response.headers}"
			#puts "Body => #{response.body}"

			if response.success?
				return JSON.parse(response.body)['properties']['relativeLocation']['properties']['state']
			else
				Rails.logger.warn "API request failed with status #{response.status}"
				return nil
			end
		end
	end
end