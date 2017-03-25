class ProfileController < ActionController::Base
  protect_from_forgery with: :exception
  layout 'profile'
  before_action :user

  private

  def user
    @user = User.find(params[:user_id])
  end
end
