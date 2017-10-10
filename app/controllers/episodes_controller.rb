class EpisodesController < ApplicationController
  before_action :set_episode, only: [:show, :edit, :update, :destroy]

  # GET /episodes
  # GET /episodes.json
  def index
    @episodes = Episode.all
  end

  # GET /episodes/1
  # GET /episodes/1.json
  def show
  end

  # GET /episodes/new
  def new
    if logged_in?
      @episode = Episode.new
    else
      redirect_to login_path
    end
  end

  # GET /episodes/1/edit
  def edit
  end

  # POST /episodes
  # POST /episodes.json
  def create
    if logged_in?
      @episode = Episode.new(episode_params)
    else
      redirect_to login_path
    end

    respond_to do |format|
      if @episode.save
        format.html { redirect_to @episode, notice: 'Episode was successfully created.' }
        format.json { render :show, status: :created, location: @episode }
      else
        format.html { render :new }
        format.json { render json: @episode.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /episodes/1
  # PATCH/PUT /episodes/1.json
  def update
    if logged_in?
      respond_to do |format|
        if @episode.update(episode_params)
          format.html { redirect_to @episode, notice: 'Episode was successfully updated.' }
          format.json { render :show, status: :ok, location: @episode }
        else
          format.html { render :edit }
          format.json { render json: @episode.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to login_path
    end
  end

  # DELETE /episodes/1
  # DELETE /episodes/1.json
  def destroy
    if logged_in?
      @episode.destroy
    else
      redirect_to login_path
    end
    
    respond_to do |format|
      format.html { redirect_to episodes_url, notice: 'Episode was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  def home
  end

  def events
  end

  def help
  end

  def about
  end

  def contact
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_episode
      @episode = Episode.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def episode_params
      params.require(:episode).permit(:id, :description)
    end
end
