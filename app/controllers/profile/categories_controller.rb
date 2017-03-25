class Profile::CategoriesController < ProfileController
  def show
    @category = find_category

    @posts = @category.posts.desc.paginate \
      page:     params[:page],
      per_page: 10
    @post_groups = @posts.group_by { |p| p.updated_at.to_date }
    @pinned_posts = @category.posts.where(pin: true)
  end

  private

  def find_category
    user = User.find(params[:user_id])
    user.categories.find(params[:id])
  end
end
