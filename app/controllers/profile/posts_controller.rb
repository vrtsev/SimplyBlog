class Profile::PostsController < ProfileController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.no_pin.desc.paginate \
      page:     params[:page],
      per_page: 10
    @post_groups = @posts.group_by { |p| p.updated_at.to_date }
    @pinned_posts = @user.posts.where(pin: true)
  end

  def show
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])

    @comment = @post.comments.new
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :tag_list, :category_id, :pin)
  end
end
