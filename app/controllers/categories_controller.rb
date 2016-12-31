class CategoriesController < ApplicationController
  before_action :set_user_category, except: [:new, :create]
  before_action :set_own_category, only: [:edit, :update, :destroy]

  def show
    if params[:user]
      redirect_to profile_path(category: params[:id], user: params[:user])
    else
      redirect_to posts_path(category: params[:id])
    end
  end

  def new
    @category = current_user.categories.new
  end

  def create
    @cat = current_user.categories.new(category_params)
    redirect_to category_path(@cat) if @cat.save
  end

  def edit; end

  def update
    redirect_to posts_path if @category.update(category_params)
  end

  def destroy
    redirect_to posts_path if @category.destroy
  end

  private

  def set_own_category
    @category = current_user.categories.find(params[:id])
  end

  def set_user_category
    return unless params[:user]
    @user = User.find(params[:user])
    @category = @user.categories.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, :description)
  end
end
