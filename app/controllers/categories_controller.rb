class CategoriesController < ApplicationController
  before_action :set_category, except: [:new, :create]

  def show
    @posts = @category.posts.order(created_at: :desc)
  end

  def new
    @cat = current_user.categories.new
  end

  def create
    @cat = current_user.categories.new(category_params)
    redirect_to category_path(@cat) if @cat.save
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def set_category
    if params[:user]
      @user = User.find(params[:user])
    else
      @user = current_user
    end
    @category = @user.categories.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, :description)
  end
end