class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]


  def home
    @users = User.all
    @skills = Skill.all
    @booking = Booking.all
    @message = Message.new
  end

  def index_chatrooms
    @chatrooms = current_user.chatrooms.all
  end

  def index_sessions
    @sessions = current_user.sessions.all
  end

  def update_booking
    @booking = Booking.find(params[:id])
    @booking.update(booking_params)
  end

  def index_reviews
    @reviews = current_user.reviews.all
  end

  def dashboard
    @skill = Skill.new
    # @booking = Booking.find(params[:id])
  end

  def new_skill
  end


  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end

end
