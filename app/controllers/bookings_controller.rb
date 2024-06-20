class BookingsController < ApplicationController
  before_action :set_skill, only: [:new, :create]


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
    @booking.duration = 3600
    @booking.content = "This is a test"
    @booking.status = "pending"
    @booking.session_format = "video"
    @booking.end_date = @booking.start_date + @booking.duration
    if current_user.token == 0
      redirect_to dashboard_path, alert: "Vous n'avez pas assez de crédit pour réserver ce cours !"
    else
      if @booking.save
        current_user.update(token: current_user.token - 1)
        redirect_to dashboard_path, notice: "Votre demande de réservation a été envoyée au professeur."
      else
        flash.now[:alert] = "Oups, il y eu un souci."
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

    @skill = Skill.new

    respond_to do |format|
      if @booking.update(booking_params)
        if @booking.status == "confirmed"
          current_user.update(token: current_user.token + 1)
          format.html { redirect_to booking_path(@booking), notice: "Vous venez d'accepeter un cours et de gagner un token" }
          format.json # Follows the classic Rails flow and look for a create.json view
        elsif @booking.status == "rejected"
          @booking.user.update(token: @booking.user.token + 1)
          format.html { redirect_to booking_path(@booking), alert: "Vous venez de refuser une demande de cours" }
          format.json # Follows the classic Rails flow and look for a create.json view
        end
      else
        flash.now[:alert] = @booking.errors.full_messages.to_sentence
        @skills = current_user.skills
        @my_bookings = Booking.where(skill: @skills)
        @bookings = current_user.bookings
        format.html { render "pages/dashboard", status: :unprocessable_entity, alert: "Votre tentative de modification échouée" }
        format.json # Follows the classic Rails flow and look for a create.json view
      end
    end
  end


  private

  def booking_params
    params.require(:booking).permit(:start_date, :content, :status, :session_format, :token_cost, :duration)
  end

  def set_skill
    @skill = Skill.find(params[:skill_id])
  end
end
