class Trip < ApplicationRecord
  has_many :spot_points, -> { order(:position) },  dependent: :destroy

  def refresh_spot_points
    spot_points.destroy_all
    saved_points = []
    _stops = stops||[]
    _stops.unshift directions['start'].values
    _stops.push directions['end'].values

    _stops.each_with_index do |stop, index|
      lat, lng = stop
      saved_points.push spot_points.create! lat: lat, lng: lng, position: index
    end


    saved_points.each_with_index do |spot, index|
      spot.update_attributes next_spot_point_ids: saved_points[(index+1)..saved_points.length-1].map(&:id)
    end
  end
end
