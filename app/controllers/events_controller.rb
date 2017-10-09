class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  # GET /events
  # GET /events.json
  def index
    @events = Event.getRecords(params[:page])
  end

  # GET /events/1
  # GET /events/1.json
  def show
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  def counties_for_state
    val = params[:us_state_id]
    @counties = County.where(:us_state_id => val)
    options = @counties.map{|x| "#{x.id} : '#{x.name}'"}
    render :json => [ @counties.to_json], :status => 200
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.getDetails(params[:id]).first
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:id, :storm_type, :begin_time, :end_time, :state_fips,
          :county_fips, :source, :forecast_office, :magnitude, :magnitude_type,
          :property_damage, :crop_damage, :narrative, :episode_id,
          locations_attributes: [:id, :event_id, :location_index, :loc_range, :azimuth, :location, :latitude, :longitude, :_destroy],
          fatalities_attributes: [:fatality_id, :fatality_date, :age, :sex, :location, :_destroy])
    end
end
