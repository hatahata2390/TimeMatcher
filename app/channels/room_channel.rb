class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "room_channel_#{params['room_id']}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    unless data['message'].empty?
      message = Message.new(chat: data['message'], user: params['user_name'], room_id: params['room_id'])
      message.save
      send_content = ApplicationController.renderer.render(partial: 'messages/message', locals: { message: message })
      ActionCable.server.broadcast "room_channel_#{params['room_id']}", message: send_content
    end
  end
  
end
