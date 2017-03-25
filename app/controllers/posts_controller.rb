class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @posts = current_user.posts.no_pin.desc.paginate \
      page:     params[:page],
      per_page: 10
    @post_groups = @posts.group_by { |p| p.updated_at.to_date }
    @pinned_posts = current_user.posts.where(pin: true)
  end

  def show
    @post = find_post
  end

  def new
    @post = current_user.posts.new
  end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      flash[:success] = 'Ваша запись была опубликована'
      redirect_to post_path(@post)
    else
      flash[:failure] = 'Ошибка. Проверьте правильность заполнения формы'
      render :new
    end
  end

  def edit
    @post = find_post
  end

  def update
    @post = find_post

    if @post.update(post_params)
      flash[:success] = 'Ваша запись была опубликована'
      redirect_to post_path(@post)
    else
      flash[:failure] = 'Ошибка. Проверьте правильность заполнения формы'
      render :new
    end
  end

  def destroy
    @post = find_post

    if @post.destroy
      flash[:success] = 'Ваша запись была удалена'
    else
      flash[:failure] = 'Ошибка. Повторите попытку'
    end
    redirect_to posts_path
  end

  private

  def find_post
    @post = current_user.posts.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content, :tag_list, :category_id, :pin)
  end
end
