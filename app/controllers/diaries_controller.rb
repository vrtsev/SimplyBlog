class DiariesController < ApplicationController
  before_action :set_diary, only: [:show, :edit, :update, :destroy]

  def index
    @diaries = current_user.diaries.all.order('created_at DESC')
  end

  def new
    @diary = Diary.new
  end

  def edit; end

  def create
    @diary = current_user.diaries.new(diary_params)

    respond_to do |format|
      if @diary.save
        format.html { redirect_to diaries_url, notice: 'Вы успешно создали запись в дневнике' }
        format.json { render :show, status: :created, location: @diary }
      else
        format.html { render :new }
        format.json { render json: @diary.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @diary.update(diary_params)
        format.html { redirect_to diaries_url, notice: 'Запись обновлена' }
        format.json { render :show, status: :ok, location: @diary }
      else
        format.html { render :edit }
        format.json { render json: @diary.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @diary.destroy
    respond_to do |format|
      format.html { redirect_to diaries_url, notice: 'Запись удалена' }
      format.json { head :no_content }
    end
  end

  private

  def set_diary
    @diary = Diary.find(params[:id])
  end

  def diary_params
    params.require(:diary).permit(:title, :content, :user_id)
  end
end
