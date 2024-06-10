class SkillsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_skill, only: [:show, :edit, :destroy]

  def index
    @skills = Skill.all
    if params[:query].present?
      # sql_subquery = "name ILIKE :query OR category ILIKE :query"
      # @skills = @skills.where(sql_subquery, query: "%#{params[:query]}%")
      @users = User.joins(:skills).where(skills: {name: params[:query]})
    else
      @users = User.skilled_users
    end
    # @skills = Skill.search_by_skills(params[:query])
  end

  def show
    @review = Review.new
    @booking = Booking.new
    @bookings = @skill.bookings
    # @reviews = @skill.reviews
    # @average_rating =@reviews.average(:rating)
  end


  def new
    @skill = Skill.new
  end


  def create
    @skill = Skill.new(skill_params)
    @skill.user = current_user
    if @skill.save
      redirect_to dashboard_path, notice: "Bravo! Votre nouvelle compétence est en ligne et réservable."
    else
      redirect_to new_skill_path, alert: "Échoué. Remplissez tous les champs."
    end
  end

  def edit
  end

  def update
    @skill = Skill.find(params[:id])
    if @skill.update(skill_params)
      redirect_to dashboard_path, notice: "Bravo! Modifié."
    else
      render 'pages/dashboard', status: :unprocessable_entity
    end
  end



  def destroy
    @skill.destroy
    redirect_to dashboard_path, status: :see_other
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
