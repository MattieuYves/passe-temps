class ChatroomsController < ApplicationController

    def index
        @chatrooms = Chatroom.all
    end

    def show
        Rails.logger.debug "Params ID: #{params[:id]}"
        @chatroom = Chatroom.find(params[:id])
        @message = Message.new
      end

end
