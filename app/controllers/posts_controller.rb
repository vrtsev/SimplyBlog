class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :check_params, only: :index

  def index
    @posts = @posts.desc.paginate \
      page:     params[:page],
      per_page: 10
    @post_groups = @posts.group_by { |p| p.updated_at.to_date }
    @pinned_posts = current_user.posts.where(pin: true).limit(2)
  end

  def show
    @comment = Comment.new
  end

  def new
    @new_post = current_user.posts.new
  end

  def edit; end

  def create
    @post = current_user.posts.new(post_params)
    render :new unless @post.save
    redirect_to @post
  end

  def update
    render :edit unless @post.update(post_params)
    redirect_to @post
  end

  def destroy
    redirect_to posts_url if @post.destroy
  end

  private

  def set_post
    @post = current_user.posts.find(params[:id])
  end

  def check_params
    if params[:category]
      @category = Category.find(params[:category])
      @posts = @category.posts
    elsif params[:tag]
      @posts = current_user.posts.tagged_with(params[:tag])
    else
      @posts = current_user.posts
    end
  end

  def post_params
    params.require(:post).permit(:title, :content, :tag_list, :category_id, :pin)
  end
end
