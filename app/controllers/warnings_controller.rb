class WarningsController < ApplicationController
  before_action :set_warning, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, :check_admin

  # GET /warnings
  # GET /warnings.json
  def index
    @warnings = Warning.all
  end

  # GET /warnings/1
  # GET /warnings/1.json
  def show
  end

  # GET /warnings/new
  def new
    @warning = Warning.new
  end

  # GET /warnings/1/edit
  def edit
  end

  # POST /warnings
  # POST /warnings.json
  def create
    @warning = Warning.new(warning_params)

    respond_to do |format|
      if @warning.save
        format.html { redirect_to @warning, notice: 'Warning was successfully created.' }
        format.json { render :show, status: :created, location: @warning }
      else
        raise 'ololo'
        format.html { render :new }
        format.json { render json: @warning.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /warnings/1
  # PATCH/PUT /warnings/1.json
  def update
    respond_to do |format|
      if @warning.update(public: warning_params[:public])
        format.html { redirect_to @warning, notice: 'Warning was successfully updated.' }
        format.json { render :show, status: :ok, location: @warning }
      else
        format.html { render :edit }
        format.json { render json: @warning.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /warnings/1
  # DELETE /warnings/1.json
  def destroy
    @warning.destroy
    respond_to do |format|
      format.html { redirect_to warnings_url, notice: 'Warning was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_warning
      @warning = Warning.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def warning_params
      params.require(:warning).permit(:title, :content, :public)
    end
end
