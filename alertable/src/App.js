import './App.css';
import React from "react";
import ParameterForm from './components/Form/ParameterForm';
import LocationForm from './components/Form/LocationForm';
import LatestLocationForm from './components/Form/LatestLocationForm';
import DownloadAlertsForm from './components/Form/DownloadAlertsForm';
import AlertForm from './components/Form/AlertForm';
import DangerZoneNotification from './components/Notification/DangerZoneNotification';


function App() {
  return (
    <div className="App">
      <ParameterForm></ParameterForm>
      <LocationForm></LocationForm>
      <LatestLocationForm></LatestLocationForm>
      <DangerZoneNotification></DangerZoneNotification>
      <DownloadAlertsForm></DownloadAlertsForm>
      <AlertForm></AlertForm>
    </div>
  );
}

export default App;
