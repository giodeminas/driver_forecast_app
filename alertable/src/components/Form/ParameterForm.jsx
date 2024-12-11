import React, { useState, useEffect } from "react";
import axios from "axios";

function ParameterForm() {
  // Initialize state to store the parameter values
  const [alertDownloadPeriod, setAlertDownloadPeriod] = useState("");
  const [dangerZoneCheckPeriod, setDangerZoneCheckPeriod] = useState("");
  
  // Fetch current parameter values from backend on component mount
  useEffect(() => {
    axios
      .get("http://localhost:3000/api/v1/parameters")
      .then((response) => {
        const parameters = response.data.parameters;

        // Update the state with the current values
        const alertParam = parameters.find((param) => param.key === "AlertDownloadPeriod");
        const driverParam = parameters.find((param) => param.key === "DangerZoneCheckPeriod");

        if (alertParam) setAlertDownloadPeriod(alertParam.value);
        if (driverParam) setDangerZoneCheckPeriod(driverParam.value);
      })
      .catch((error) => {
        console.error("Error fetching parameters:", error);
      });
  }, []);

  // Handle change for AlertDownloadPeriod input
  const handleAlertDownloadPeriodChange = (e) => {
    setAlertDownloadPeriod(e.target.value);
  };

  // Handle change for DangerZoneCheckPeriod input
  const handleDangerZoneCheckPeriodChange = (e) => {
    setDangerZoneCheckPeriod(e.target.value);
  };

  // Handle form submission
  const handleSubmit = (e) => {
    e.preventDefault();

    // Send data to Rails backend to update the parameters
    axios
      .post("http://localhost:3000/api/v1/parameters", {
        alert_download_period: alertDownloadPeriod,
        danger_zone_check_period: dangerZoneCheckPeriod,
      })
      .then((response) => {
        console.log("Parameters updated successfully:", response.data);
      })
      .catch((error) => {
        console.error("There was an error submitting the form:", error);
      });

      // Reload the page after a successful response
      window.location.reload();
  };

  return (
    <div>
      <h1>Period Parameter Values In Minutes</h1>
      <form onSubmit={handleSubmit}>
        <div>
          <label>Alert Download Period:</label>
          <input
            type="text"
            value={alertDownloadPeriod}
            onChange={handleAlertDownloadPeriodChange}
            required
          />
        </div>
        <div>
          <label>Danger Zone Check Period:</label>
          <input
            type="text"
            value={dangerZoneCheckPeriod}
            onChange={handleDangerZoneCheckPeriodChange}
            required
          />
        </div>
        <button type="submit">Submit</button>
      </form>
    </div>
  );
}

export default ParameterForm;
