class ProfileController < ApplicationController
  before_action :set_user
  before_action :check_user
  before_action :check_params, only: :index

  def index
    @posts = @posts.desc.paginate \
      page:     params[:page],
      per_page: 10
    @post_groups = @posts.group_by { |p| p.updated_at.to_date }
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

  def check_user
    if !@user.visible
      redirect_to '/422'
    elsif @user == current_user
      redirect_to posts_path(category: params[:category])
    end
  end

  def check_params
    if params[:category]
      @category = Category.find(params[:category])
      @posts = @category.posts
    elsif params[:tag]
      @posts = @user.posts.tagged_with(params[:tag])
    else
      @posts = @user.posts
    end
  end

  def post_params
    params.require(:post).permit(:title, :content, :tag_list, :category_id)
  end
end
