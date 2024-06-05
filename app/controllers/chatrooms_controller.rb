class ChatroomsController < ApplicationController

    def index
        @chatrooms = Chatroom.all
    end

    def show
        @chatroom = Chatroom.find(params[:id])
        @name = @chatroom.booking.user == current_user ? @chatroom.booking.skill.user.first_name.capitalize : @chatroom.booking.user.first_name.capitalize
        @message = Message.new
    end

end