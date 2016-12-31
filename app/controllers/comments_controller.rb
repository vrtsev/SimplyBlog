class CommentsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_post
  before_action :set_comment, except: [:create]

  def edit; end

  def create
    @comment = @post.comments.new(comment_params)
    @comment.user_id = current_user.id
    render :new unless @comment.save
    redirect_to profile_post_path(@post.user, @post)
  end

  def update
    render :edit unless @comment.update_attributes(comment_params)
    redirect_to @post
  end

  def destroy
    redirect_to @post if @comment.destroy
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_comment
    @comment = @post.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content, :post_id, :user_id)
  end
end
