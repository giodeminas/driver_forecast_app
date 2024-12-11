import { useEffect, useState } from 'react';
import axios from "axios";
import Table from "../Table/Table";

function AlertForm() {

    const API_URL = "http://localhost:3000/api/v1/alerts";

    const [alerts, setAlerts] = useState([]);

    function getAPIData() {
        return axios.get(API_URL).then((response) => response.data)
    }
  
    useEffect(() => {
        let mounted = true;
        getAPIData().then((items) => {
            if (mounted) {
                setAlerts(items);
            }
        });
        return () => (mounted = false) ;
    }, []);
  
    return (
        <div>
            <h1>Alerts</h1>
            <Table data={alerts}></Table>
        </div>
    );
}

export default AlertForm;