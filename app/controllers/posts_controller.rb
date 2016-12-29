class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :check_admin, only: [:edit, :update, :destroy]

  def index
    @pub_warnings = Warning.all
    @posts = Post.all.order('created_at DESC')
    logger.info "Showing public warnings and Posts in DESC order"
  end

  def show
    @comment = Comment.new
  end

  def edit; end

  def create
    @post = current_user.posts.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Вы успешно создали сообщение' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Вы успешно обновили сообщение' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Пост был удален' }
      format.json { head :no_content }
    end
  end

  def likes
    @post = Post.find(params[:post_id])
    @post.increment!(:likes)
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Вы оценили запись' }
    end
  end

  def my_posts
    @my_posts = current_user.posts
  end

  def my_comments
    @my_comments = current_user.comments
  end

  def about
    @r = rand(1..2) # => 22
    render action: "about_site", layout: "about"
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content, :user_id, :likes)
  end

end
