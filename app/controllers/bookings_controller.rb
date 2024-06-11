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
    # raise
    if current_user.token == 0
      redirect_to dashboard_path, notice: "Vous n'avez pas assez de crédit pour réserver ce cours !"
    else
      if @booking.save
        current_user.update(token: current_user.token - 1)
        redirect_to dashboard_path, notice: "Bravo! Votre demande de réservation a été envoyée au professeur."
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


    if @booking.update(booking_params)
      case @booking.status
      when "confirmée"
        redirect_to dashboard_path, notice: "Bravo! Vous venez d'accepter une nouvelle réservation ! 🤑"
        current_user.update(token: current_user.token + 1)
      when "refusée"
        redirect_to dashboard_path, notice: "La demande de réservation a été refusée 😩"
        booking.user.update(token: booking.user.token - 1)
      else
        redirect_to dashboard_path, alert: "Tentative de mise à jour du statut non valide."
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
    params.require(:booking).permit(:start_date, :content, :status, :session_format, :token_cost, :duration)
  end

  def set_skill
    @skill = Skill.find(params[:skill_id])
  end
end
