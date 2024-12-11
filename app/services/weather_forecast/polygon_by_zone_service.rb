module WeatherForecast
	require 'faraday'
	require 'rgeo'

	class PolygonByZoneService
		def initialize(zone)
			@zone = zone
		end

		def call
			response = Faraday.get("https://api.weather.gov/zones/forecast/" + @zone )

			#puts "Status => #{response.status}"
			#puts "Headers => #{response.headers}"
			#puts "Body => #{response.body}"

			if response.success?
    			parse_polygon(JSON.parse(response.body)['geometry'])
			else
				Rails.logger.warn "API request failed with status #{response.status}"
				return nil
			end
		end

		def parse_polygon(geometry)
			# Initialize the factory
			factory = RGeo::Geographic.spherical_factory(srid: 4326)

			case geometry['type']
			when 'Polygon'
			  create_polygon(factory, geometry['coordinates'])
			when 'MultiPolygon'
			  create_multi_polygon(factory, geometry['coordinates'])
			else
			  raise "Unsupported geometry type: #{geometry['type']}"
			end
		end

		def create_polygon(factory, coordinates)
			exterior_ring = coordinates[0].map { |lng, lat| factory.point(lng, lat) }
			linear_ring = factory.linear_ring(exterior_ring)
			factory.polygon(linear_ring)
	  	end
	  
		def create_multi_polygon(factory, coordinates)
			polygons = coordinates.map { |polygon_coords| create_polygon(factory, polygon_coords) }
			factory.multi_polygon(polygons)
		end
	end
end