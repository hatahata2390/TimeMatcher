class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "room_channel_#{params['room_id']}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    Message.create!(chat: data['message'], user: params['user_name'], room_id: params['room_id'])
    ActionCable.server.broadcast "room_channel_#{params['room_id']}", message: "#{params['user_name']}: #{data['message']}"
  end
end
