class WarningsController < ApplicationController
  before_action :set_warning, only: [:show, :edit, :set_public, :update, :destroy]
  before_action :authenticate_user!, :check_admin

  def index
    @warnings = Warning.all
  end

  def show; end

  def new
    @warning = Warning.new
  end

  def edit; end

  def set_public
    @warning.publ
    @warning.save
    redirect_to root_path
  end

  def create
    @warning = Warning.new(warning_params)
    respond_to do |format|
      if @warning.save
        format.html { redirect_to "/admins/index", notice: 'Warning was successfully created.' }
        format.json { render :show, status: :created, location: @warning }
      else
        format.html { render :new }
        format.json { render json: @warning.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @warning.update(warning_params)
        format.html { redirect_to "/admins/index", notice: 'Warning was successfully updated.' }
        format.json { render :show, status: :ok, location: @warning }
      else
        format.html { render :edit }
        format.json { render json: @warning.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @warning.destroy
    respond_to do |format|
      format.html { redirect_to "/admins/index", notice: 'Warning was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_warning
    @warning = Warning.find(params[:id])
  end

  def warning_params
    params.require(:warning).permit(:title, :content, :public)
  end
end
