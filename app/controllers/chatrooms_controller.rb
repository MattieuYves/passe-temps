class ChatroomsController < ApplicationController
    def index
      @chatrooms = Chatroom.all
    end
  
    def show
      @chatroom = Chatroom.find(params[:id])
      @name = @chatroom.booking.user == current_user ? @chatroom.booking.skill.user.first_name.capitalize : @chatroom.booking.user.first_name.capitalize
      @message = Message.new
      respond_to do |format|
        format.html
        format.json do
          response = {
            html: render_to_string(partial: "shared/chatroom", locals: { chatroom: @chatroom }, formats: :html, layout: false)
          }
          render json: response.to_json
        end
      end
    end
  
    def mark_as_read
      @chatroom = Chatroom.find(params[:id])
      @chatroom.messages.where(read: false).where.not(user: current_user).update_all(read: true)
      head :ok
    end
  end