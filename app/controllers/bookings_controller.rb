class BookingsController < ApplicationController

  def show
    @booking = Booking.find(params[:id])
    @chatroom = @booking.chatroom
    @review = Review.new
  end

  def create
    @skill = Skill.find(params[:skill_id])
    @booking = Booking.new(booking_params)
    @booking.skill = @skill
    @booking.user = current_user
    @booking.token_cost = 1
    @booking.duration = 1
    @booking.content = "This is a test"
    @booking.status = "pending"
    @booking.session_format = "video"

    if current_user.token == 0
      redirect to_dashboard_path, notice: "You don't have enough token to book this course!"
    else
      if @booking.save
        current_user.token = current_user.token - 1
        redirect_to dashboard_path, notice: "Congrats! Your booking request has been sent to the teacher."
      else
        flash.now[:alert] = "Oops, something went wrong."
        render 'skills/show', status: :unprocessable_entity
      end
    end


  end

  def new
    @skill = Skill.find(params[:skill_id])
    @booking = Booking.new
  end


  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy
    redirect_to dashboard_path, status: :see_other
  end

  def update
    @booking = Booking.find(params[:id])


    if @booking.update(booking_params)
      case @booking.status
      when "confirmed"
        redirect_to dashboard_path, notice: "Congrats! You just accepted a new booking! 🤑"
      when "rejected"
        redirect_to dashboard_path, notice: "The booking request has been rejected 😩"
      else
        redirect_to dashboard_path, alert: "Invalid status update attempted."
      end
    else
      flash.now[:alert] = @booking.errors.full_messages.to_sentence
      @skills = current_user.skills
      @my_bookings = Booking.where(skill: @skills)
      @bookings = current_user.bookings
      render 'pages/dashboard', status: :unprocessable_entity
    end
  end


  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :content, :status, :session_format, :token_cost, :duration)
  end

end
