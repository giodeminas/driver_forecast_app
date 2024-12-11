import React, { useEffect } from 'react';
import { ToastContainer, toast } from 'react-toastify';
import 'react-toastify/dist/ReactToastify.css';
import ActionCable from 'actioncable';

const DangerZoneNotification = () => {
    useEffect(() => {
        // Set up ActionCable connection to the server
        const cable = ActionCable.createConsumer('ws://localhost:3000/cable');  // Ensure your WebSocket URL is correct
    
        // Subscribe to the danger_zone_channel
        const channel = cable.subscriptions.create('DangerZoneChannel', {
          received: (data) => {
            // Show a toast notification when data is received
            if (data.message) {
              toast.warn(data.message);
            }
          }
        });
    
        // Cleanup on component unmount
        return () => {
          channel.unsubscribe();
        };
      }, []);
    
      return (
        <div>
          <ToastContainer 
          position="bottom-right"
          autoClose={60000}
          newestOnTop
          closeOnClick
          pauseOnHover
          theme="dark" />
        </div>
      );
    };

export default DangerZoneNotification;
