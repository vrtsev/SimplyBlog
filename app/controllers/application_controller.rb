class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :new_post
  layout :layout_by_resource

  private

  def new_post
    return unless user_signed_in?
    @new_post = current_user.posts.new
  end

  def layout_by_resource
    'home' if devise_controller? && resource_name == :user && action_name == 'new'
  end
end
