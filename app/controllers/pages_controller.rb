class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @users = User.all
  end

  def index_chatrooms
    @chatrooms = current_user.chatrooms.all
  end

  def index_sessions
    @sessions = current_user.sessions.all
  end

  def update_session
    @session = Session.find(params[:id])
    @session.update(session_params)
  end

  def index_reviews
    @reviews = current_user.reviews.all
  end

  def dashboard
  end

  private

  def session_params
    params.require(:session).permit(:start_date, :end_date)
  end

end
