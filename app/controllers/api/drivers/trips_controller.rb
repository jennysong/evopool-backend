class Api::Drivers::TripsController < Api::DriversController
  def create
    trip = collection.new trip_params
    if trip.save
      render json: {status: :ok}, status: :ok
    else
    render json: {status: :invalid}, status: 422
    end
  end

  def index
    @trips = Trip.all
  end

private

  def collection
    Trip
  end

  def trip_params
    return @_trip_params if @_trip_params.present?
    @_trip_params = params.permit(start_at: [:date, :time], directions: {start: [:lat, :lng], end: [:lat, :lng] })
    @_trip_params.tap do |whitelisted|
      whitelisted[:start_at] = current_timezone.parse("#{whitelisted[:start_at][:date]} #{whitelisted[:start_at][:time]}") rescue current_timezone.now
      whitelisted[:directions][:waypoints] = params[:directions][:waypoints]
      whitelisted[:stops] = params[:stops]
    end
    @_trip_params
  end
end