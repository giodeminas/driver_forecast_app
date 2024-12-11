import React, { useState } from "react";
import axios from "axios";

function LocationForm() {
  const [locationData, setLocationData] = useState({
    latitude: "",
    longitude: "",
  });

  // Handle changes in latitude and longitude
  const handleLocationChange = (e) => {
    const { name, value } = e.target;
    setLocationData({ ...locationData, [name]: value });
  };

  // Handle form submission
  const handleSubmit = (e) => {
    e.preventDefault();

    // Send data to Rails backend
    axios
      .post("http://localhost:3000/api/v1/locations", locationData)
      .then((response) => {
        console.log("Location data submitted successfully:", response.data);
      })
      .catch((error) => {
        console.error("There was an error submitting the form:", error);
      });

     // Reload the page after a successful response
     window.location.reload();
  };

  return (
    <div>
      <h1>Submit New Location Data</h1>
      <form onSubmit={handleSubmit}>
        <div>
          <label>Latitude:</label>
          <input
            type="number"
            name="latitude"
            value={locationData.latitude}
            onChange={handleLocationChange}
            required
          />
        </div>
        <div>
          <label>Longitude:</label>
          <input
            type="number"
            name="longitude"
            value={locationData.longitude}
            onChange={handleLocationChange}
            required
          />
        </div>

        <button type="submit">Submit</button>
      </form>
    </div>
  );
}

export default LocationForm;
