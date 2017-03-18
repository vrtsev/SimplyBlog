class UsersController < ApplicationController
  layout 'users'

  def index
    @users = User.order(id: :desc).paginate \
      page: params[:page],
      per_page: 16
  end
end
