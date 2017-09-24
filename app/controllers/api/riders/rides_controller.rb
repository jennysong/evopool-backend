class Api::Riders::RidesController < Api::RidersController
  def index
    @rides = User::Ride.all
  end

  def show
    @ride = User::Ride.find(params[:id])
  end

  def create
    trip              = Trip.find_by_id(ride_params[:trip_id])
    origin_point      = Trip::SpotPoint.find_by_id(ride_params[:origin_stop_id])
    destination_point = Trip::SpotPoint.find_by_id(ride_params[:destination_stop_id])

    @ride = User::Ride.new trip: trip, origin_spot_point: origin_point, destination_spot_point: destination_point

    if @ride.save
      render :show
    else
      render json: {status: :invalid}, status: 422
    end
  end

private
  def ride_params
    @_ride_params ||= params.permit(:trip_id, :origin_stop_id, :destination_stop_id)
  end
end