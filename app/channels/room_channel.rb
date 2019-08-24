class RoomChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "room_channel"
    stream_from "room_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    Message.create!(chat: data['message'], user: "temp", room_id: 1)
    ActionCable.server.broadcast 'room_channel', message: data['message']
  end
end
