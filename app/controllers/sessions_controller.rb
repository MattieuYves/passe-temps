class SessionsController < ApplicationController

  def create
    @skill = Skill.find(params[:offer_id])
    @session = Session.new(booking_params)
    @session.skill = @skill
    @session.user = current_user
    if @session.save
      redirect_to dashboard_path, notice: "Congrats! Your session request has been sent to the teacher."
    else
      flash.now[:alert] = "Oops, something went wrong."
      render 'skills/show', status: :unprocessable_entity
    end
  end

  def destroy
    @session = Session.find(params[:id])
    @session.destroy
    redirect_to skill_path(@session.skill), status: :see_other
  end

  def status_update
    @session = Session.find(params[:id])
    @session.update(status: params[:status])
  end

  private

  def session_params
    params.require(:session).permit(:start_date, :end_date)
  end

end
