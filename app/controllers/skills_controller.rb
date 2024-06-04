class SkillsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_goat, only: [:show]

  def index
    @skills = Skill.all
    if params[:query].present?
      sql_subquery = "name ILIKE :query OR category ILIKE :query"
      @skills = @skills.where(sql_subquery, query: "%#{params[:query]}%")
    end
  end

  def show
    @review = Review.new
    @booking = Booking.new
    @bookings = @skill.bookings
  end

  def new
    @skill = Skill.new
  end

  def create
    @skill = Skill.new(skill_params)
    @skill.user = current_user
    if @skill.save
      redirect_to skill_path(@skill), notice: "Congrats! Your new skill is online and bookable."
    else
      redirect_to new_offer_path, alert: "Failed. Fill in all fields"
    end
  end

  def destroy
    @skill.destroy
    redirect_to root_path, status: :see_other
  end

  private

  def set_skill
    @skill = Skill.find(params[:id])
  end

# ajouter photo dans les params permit au moment de passer à Cloudinary

  def skill_params
    params.require(:skill).permit(:name, :goal, :experience_year, :category, :photo)
  end

end
