class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  before_action :reject_current_user

  def all
    user = AuthorizationCreator.new(env["omniauth.auth"]).user
    if user.persisted?
      flash[:notice] = "Вы успешно авторизировались."
      sign_in_and_redirect(user)
    else
      session["devise.user_attributes"] = user.attributes
      redirect_to new_user_registration_url
    end
  end

  alias_method :google_oauth2, :all
  alias_method :vkontakte, :all

  private

  def reject_current_user
    redirect_to :root if signed_in?
  end
end