class Api::Riders::TripsController < Api::RidersController
  def search
    from_points = Trip::SpotPoint.where('start_at >= ? and start_at <= ?', search_params[:start_at], search_params[:start_at] + 1.hour).near search_params[:from].values, (search_params[:radius]||0.5).to_f, unit: :km
    possible_point_ids = from_points.map(&:next_spot_point_ids).flatten.uniq
    to_points = Trip::SpotPoint.where(id: possible_point_ids).near(search_params[:to].values, (search_params[:radius]||0.5).to_f, unit: :km)

    trip_ids = to_points.map(&:trip_id).uniq
    @trips = Trip.where(id: trip_ids)
    render :index
  end

private

  def search_params
    return @_search_params if @_search_params.present?
    @_search_params = params.permit(:start_at, :radius, from: [:lat, :lng], to: [:lat, :lng])
    @_search_params.tap do |whitelisted|
      whitelisted[:start_at] = Time.parse whitelisted[:start_at]
    end
    @_search_params
  end
end