import React, { useEffect, useState } from "react";
import axios from "axios";

function LatestLocation() {
  const [location, setLocation] = useState(null);
  const [error, setError] = useState("");

  // Fetch the latest location on component mount
  useEffect(() => {
    axios
      .get("http://localhost:3000/api/v1/locations/latest")
      .then((response) => {
        setLocation(response.data.location);
      })
      .catch((err) => {
        console.error("Error fetching latest location:", err);
        setError("Could not fetch the latest location.");
      });
  }, []);

  // Render the location details or an error message
  return (
    <div>
      <h1>Latest Location</h1>
      {error ? (
        <p style={{ color: "red" }}>{error}</p>
      ) : location ? (
        <div>
          <p><strong>Latitude:</strong> {location.latitude}</p>
          <p><strong>Longitude:</strong> {location.longitude}</p>
          <p><strong>State:</strong> {location.state}</p>
          <p><strong>Created At:</strong> {new Date(location.created_at).toLocaleString()}</p>
        </div>
      ) : (
        <p>Loading latest location...</p>
      )}
    </div>
  );
}

export default LatestLocation;
