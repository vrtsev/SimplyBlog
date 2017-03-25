class Profile::CommentsController < ProfileController
  before_action :find_user, :find_post

  def create
    @comment = @post.comments.new(comment_params)
    @comment.user = current_user

    if @comment.save
      flash[:success] = 'Ваш комментарий к записи был опубликован'
      redirect_to user_post_path(@user, @post)
    else
      flash[:failure] = 'Ошибка. Проверьте правильность заполнения формы'
      render :new
    end
  end

  def edit
    @comment = @post.comments.find(params[:id])
  end

  def update
    @comment = @post.comments.find(params[:id])

    if @comment.update(comment_params)
      flash[:success] = 'Ваш комментарий к записи был обновлен'
      redirect_to user_post_path(@user, @post)
    else
      flash[:failure] = 'Ошибка. Проверьте правильность заполнения формы'
      render :edit
    end
  end

  def destroy
    @comment = @post.comments.find(params[:id])

    if @comment.destroy
      flash[:success] = 'Ваш комментарий к записи был удален'
    else
      flash[:failure] = 'Ошибка. Повторите попытку'
    end
    redirect_to user_post_path(@user, @post)
  end

  private

  def find_user
    @user = User.find(params[:user_id])
  end

  def find_post
    @post = @user.posts.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:content, :post_id, :user_id)
  end
end
