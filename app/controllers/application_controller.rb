class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  layout :layout_by_resource

  private

  def layout_by_resource
    'home' if devise_controller? && resource_name == :user && action_name == 'new'
  end
end
