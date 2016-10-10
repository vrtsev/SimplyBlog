class AdminsController < ApplicationController
  # before_action :set_admin, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, :register
  before_action :check_admin, only: [:clear_history]

  def index
  end

  def users
    @users = User.all
  end

  def posts
    @posts = Post.all.order('created_at DESC')
  end

  def history
    @history = History.limit(10).order('created_at DESC')
  end

  def clear_history
    @history = History.destroy_all
    redirect_to action: "history"
  end

  private

    def register
      unless History.last
        History.create(user_id: 1, action: "clear_history")
      else
        History.register(user_id: current_user.id, action: action_name) unless History.last.action == action_name
      end
    end
end
