class PostsController < ApplicationController
  require 'json'


  skip_before_action :verify_authenticity_token
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show, :about]

  # GET /posts
  # GET /posts.json
  def index
    @pub_warnings = Warning.all
    @posts = Post.all.order('created_at DESC')
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @comment = Comment.new
  end

  # GET /posts/new
  # Этот метод отдельно вынесен в паршиал, чтобы к нему был доступ через модальное окно
  # def new
  #   @post = Post.new
  # end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
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

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
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

  # DELETE /posts/1
  # DELETE /posts/1.json
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
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :content, :user_id, :likes)
    end

end
