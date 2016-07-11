class LanguagesController < ApplicationController
  before_action :set_language, only: [:show, :update, :destroy]

  # GET /languages
  # GET /languages.json
  def index
    @languages = Language.all

    render json: @languages
  end

  # GET /languages/1
  # GET /languages/1.json
  def show
    render json: @language
  end

  # POST /languages
  # POST /languages.json
  def create
    @language = Language.new(language_params)

    if @language.save
      render json: @language, status: :created, location: @language
    else
      render json: @language.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /languages/1
  # PATCH/PUT /languages/1.json
  def update
    @language = Language.find(params[:id])

    if @language.update(language_params)
      head :no_content
    else
      render json: @language.errors, status: :unprocessable_entity
    end
  end

  # DELETE /languages/1
  # DELETE /languages/1.json
  def destroy
    @language.destroy

    head :no_content
  end

  private

    def set_language
      @language = Language.find(params[:id])
    end

    def language_params
      params.require(:language).permit(:name, :description)
    end
end
