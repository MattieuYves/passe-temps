class ApplicationController < ActionController::Base
  before_action :authenticate_user!, :set_chatrooms
  private

  def set_chatrooms
    @chatrooms = current_user.chatrooms
  end
end
