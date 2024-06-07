class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :set_chatrooms, if: :user_signed_in?
  private

  def set_chatrooms
    @chatrooms = current_user.chatrooms
  end
  

end
