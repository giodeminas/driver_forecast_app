class DangerZoneChannel < ApplicationCable::Channel
  def subscribed
    # You can set a stream for specific users or groups, like user-specific or global
    stream_from "danger_zone_channel"
  end

  def unsubscribed
    # Any cleanup needed when the channel is unsubscribed
  end

  def send_alert(data)
    # Broadcasting a message to the frontend
    ActionCable.server.broadcast "danger_zone_channel", message: data['message']
  end
end