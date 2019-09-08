# もともとモデルの以下コミットを受けて動く仕様だった
# ジョブからだとブロードキャストがどうしてもうまく行かなかった　パラメータはあってたんだけどな。。。
# after_create_commit { MessageBroadcastJob.perform_later self }

class MessageBroadcastJob < ApplicationJob
 queue_as :default

  def perform(message)
    ActionCable.server.broadcast "room_channel_#{message.room_id}", message: "test"
    debugger
    # ActionCable.server.broadcast "room_channel_#{message.room_id}", message: render_message(message)
  end

    private

    def render_message(message)
      ApplicationController.renderer.render(partial: 'messages/message', locals: { message: message })
    end
end
