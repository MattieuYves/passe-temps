class BookingsController < ApplicationController

  def create
    @skill = Skill.find(params[:offer_id])
    @booking = Booking.new(booking_params)
    @booking.skill = @skill
    @booking.user = current_user
    if @booking.save
      redirect_to dashboard_path, notice: "Congrats! Your booking request has been sent to the teacher."
    else
      flash.now[:alert] = "Oops, something went wrong."
      render 'skills/show', status: :unprocessable_entity
    end
  end

  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy
    redirect_to skill_path(@booking.skill), status: :see_other
  end

  def status_update
    @booking = Booking.find(params[:id])
    @booking.update(status: params[:status])
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end

end
