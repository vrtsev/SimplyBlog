class AuthorizationCreator
  attr_reader :user

  def initialize(auth_object)
    @auth_object = auth_object
    @authorization = find_authorizaion
    @user = find_user

    assign_auth_user! unless @authorization.user.present?
  end

  private

  def find_authorizaion
    Authorization.find_or_new_for_oauth(@auth_object)
  end

  def find_user
    return @authorization.user if @authorization.user.present?
    existed_user || new_user
  end

  def existed_user
    user_by_auth_email || user_by_generated_email
  end

  def user_by_auth_email
    return unless @auth_object.info.email.present?
    User.find_by(email: @auth_object.info.email)
  end

  def user_by_generated_email
    User.find_with_generated_email(@auth_object)
  end

  def new_user
    User.create_for_oauth(@auth_object)
  end

  def assign_auth_user!
    @authorization.user = @user
    @authorization.save
  end
end
