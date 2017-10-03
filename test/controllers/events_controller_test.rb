require 'test_helper'

class EventsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @event = events(:one)
  end

  test "should get index" do
    get events_url
    assert_response :success
  end

  test "should get new" do
    get new_event_url
    assert_response :success
  end

  test "should create event" do
    assert_difference('Event.count') do
      post events_url, params: { event: { begin_time: @event.begin_time, county_fips: @event.county_fips, crop_damage: @event.crop_damage, end_time: @event.end_time, episode_id: @event.episode_id, forecast_office: @event.forecast_office, id: @event.id, magnitude: @event.magnitude, magnitude_type: @event.magnitude_type, narrative: @event.narrative, property_damage: @event.property_damage, source: @event.source, state_fips: @event.state_fips, storm_type: @event.storm_type } }
    end

    assert_redirected_to event_url(Event.last)
  end

  test "should show event" do
    get event_url(@event)
    assert_response :success
  end

  test "should get edit" do
    get edit_event_url(@event)
    assert_response :success
  end

  test "should update event" do
    patch event_url(@event), params: { event: { begin_time: @event.begin_time, county_fips: @event.county_fips, crop_damage: @event.crop_damage, end_time: @event.end_time, episode_id: @event.episode_id, forecast_office: @event.forecast_office, id: @event.id, magnitude: @event.magnitude, magnitude_type: @event.magnitude_type, narrative: @event.narrative, property_damage: @event.property_damage, source: @event.source, state_fips: @event.state_fips, storm_type: @event.storm_type } }
    assert_redirected_to event_url(@event)
  end

  test "should destroy event" do
    assert_difference('Event.count', -1) do
      delete event_url(@event)
    end

    assert_redirected_to events_url
  end
end
