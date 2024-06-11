class SkillsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_skill, only: [:show, :edit, :destroy]

  def index
    @skills = Skill.all
    if params[:query].present?
      # sql_subquery = "name ILIKE :query OR category ILIKE :query"
      # @skills = @skills.where(sql_subquery, query: "%#{params[:query]}%")
      @users = User.joins(:skills).where(skills: {name: params[:query]})
    elsif params[:category].present?
      @users = User.joins(:skills).where(skills: {category: params[:category]})
    else
      @users = User.skilled_users
    end
    # The `geocoded` scope filters only flats with coordinates
    @markers = @users.geocoded.map do |user|
      {
        lat: user.latitude,
        lng: user.longitude,
        info_window_html: render_to_string(partial: "shared/card", locals: { user: user }),
        marker_html: render_to_string(partial: "shared/marker")
      }
    end
    # @skills = Skill.search_by_skills(params[:query])
  end

  def show
    @review = Review.new
    @booking = Booking.new
    @bookings = @skill.bookings
    if params[:date].present?
      @slots = ComputeDaySlots.new(bookings: day_bookings(DateTime.parse(params[:date]))).call
    else
      @slots = ComputeDaySlots.new(bookings: day_bookings(DateTime.now)).call
    end

    respond_to do |format|
      format.html # Follow regular flow of Rails
      @list = render_to_string(partial: "skills/slots", locals: {slots: @slots}, formats: [:html])
      format.json { render json: { list: @list } }
    end
  end


  def new
    @skill = Skill.new
  end


  def create
    @skill = Skill.new(skill_params)
    @skill.user = current_user
    # if @skill.save
    #   redirect_to dashboard_path, notice: "Bravo! Votre nouvelle compétence est en ligne et réservable."
    # else
    #   redirect_to new_skill_path, alert: "Échoué. Remplissez tous les champs."
    # end
    respond_to do |format|
      if @skill.save
        format.html { redirect_to skill_path(@skill), notice: "Bravo! Votre nouvelle compétence est en ligne et réservable." }
        format.json # Follows the classic Rails flow and look for a create.json view

      else
        format.html { render "pages/dashboard", status: :unprocessable_entity, alert: "Échoué. Remplissez tous les champs." }
        format.json # Follows the classic Rails flow and look for a create.json view
      end
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

  def day_bookings(day)
    @skill.bookings.where(start_date: day.beginning_of_day..day.end_of_day)
  end

end
