import React, { useState } from "react";
import axios from "axios";

function DownloadAlertsForm() {
  const [message, setMessage] = useState("");
  const [error, setError] = useState("");

  const handleButtonClick = async () => {
    try {
      const response = await axios.post("http://localhost:3000/api/v1/alerts/download");
      setMessage(response.data.message);
      setError(""); // Clear any previous errors
    } catch (err) {
      setError(err.response?.data?.error || "Something went wrong!");
      setMessage(""); // Clear any previous success message
    }

    // Reload the page after a successful response
    window.location.reload();
  };

  return (
    <div>
      <button onClick={handleButtonClick}>Get State And Download Alerts</button>
      {message && <p style={{ color: "green" }}>{message}</p>}
      {error && <p style={{ color: "red" }}>{error}</p>}
    </div>
  );
}

export default DownloadAlertsForm;
