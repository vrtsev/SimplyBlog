class CategoriesController < ApplicationController
  def show
    @category = find_category
    @posts = @category.posts.desc.paginate \
      page:     params[:page],
      per_page: 10
    @post_groups = @posts.group_by { |p| p.updated_at.to_date }
    @pinned_posts = @category.posts.where(pin: true)
  end

  def new
    @category = current_user.categories.new
  end

  def create
    @category = current_user.categories.new(category_params)
    redirect_to category_path(@category) if @category.save
  end

  def edit
    @category = find_category
  end

  def update
    @category = find_category
    redirect_to category_path(@category) if @category.update(category_params)
  end

  def destroy
    @category = find_category
    redirect_to posts_path if @category.destroy
  end

  private

  def find_category
    current_user.categories.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, :description)
  end
end
