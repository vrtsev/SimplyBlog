class CommentsController < ApplicationController

  skip_before_action :verify_authenticity_token

	def new
		@comment = Comment.new
	end

  def edit
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    update
  end

	def create
		@post = Post.find(params[:post_id])
    @comment = @post.comments.build(params[:comment].permit(:content))
    @comment.user_id = current_user.id
    @comment.save!

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @post, notice: 'Вы успешно создали комментарий' }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @comment.update(post_params)
        format.html { redirect_to @comment, notice: 'Вы успешно обновили комментарий' }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to @post, notice: 'Комментарий был удален' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:content, :post_id, :user_id)
    end
end
