class Api::Riders::TripsController < Api::RidersController
  def search
    origin_points = Trip::SpotPoint.where('start_at >= ? and start_at <= ?', search_params[:start_at], search_params[:start_at] + 1.hour).near search_params[:from].values, (search_params[:radius]||0.5).to_f, unit: :km
    possible_point_ids = origin_points.map(&:next_spot_point_ids).flatten.uniq
    destination_points = Trip::SpotPoint.where(id: possible_point_ids).near(search_params[:to].values, (search_params[:radius]||0.5).to_f, unit: :km)

    trip_ids = destination_points.map(&:trip_id).uniq
    @trips = Trip.where(id: trip_ids)
    @trips.each do |trip|
      trip.set_origin_point origin_points
      trip.set_destination_point destination_points
    end
    render :index
  end

private

  def search_params
    return @_search_params if @_search_params.present?
    @_search_params = params.permit(:start_at, :radius, from: [:lat, :lng], to: [:lat, :lng])
    @_search_params.tap do |whitelisted|
      whitelisted[:start_at] = whitelisted[:start_at].to_time
    end
    @_search_params
  end
end