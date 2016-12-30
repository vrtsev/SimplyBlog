class ProfileController < ApplicationController
  before_action :set_user

  def index
    redirect_to posts_path if @user == current_user
    @posts = @user.posts.desc.paginate \
      :page => params[:page],
      :per_page => 10
    @post_groups = @posts.group_by {|p| p.created_at.to_date}
    @pinned_posts = @user.posts.where(pin: true).limit(2)
  end

  def show
    @post = @user.posts.find(params[:id])
    @comment = Comment.new
    redirect_to post_path(@post) if @user == current_user
  end

  private

  def set_user
    @user = User.find(params[:user])
  end

  def post_params
    params.require(:post).permit(:title, :content, :tag_list, :category_id)
  end
end
