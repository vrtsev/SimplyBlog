class HomeController < ApplicationController
  before_action :check_authentication
  layout 'home'

  def index
  end

  private

  def check_authentication
    redirect_to posts_path if user_signed_in?
  end

end