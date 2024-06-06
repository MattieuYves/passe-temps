class ChatroomChannel < ApplicationCable::Channel
  def subscribed
    chatroom = Chatroom.find(params[:id])
    stream_for chatroom
  end

  def receive(data)
    message = Message.find(data["id"])
    message.mark_as_read! if data["read"]
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
