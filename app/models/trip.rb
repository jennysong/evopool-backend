class Trip < ApplicationRecord
  attr_accessor :origin_point, :destination_point
  has_many :spot_points, -> { order(:position) },  dependent: :destroy

  validates :start_at, :directions, :stops, presence: true
  validates_datetime :start_at, after: -> { Time.now + 1.hour }

  def set_origin_point(spot_points)
    self.origin_point = spot_points.find { |point| point.trip_id == id }

  end

  def set_destination_point(spot_points)
    self.destination_point = spot_points.find { |point| point.trip_id == id }
  end

private

  before_validation :refresh_stops_from_waypoints

  def refresh_stops_from_waypoints
    self.stops = []
    self.stops.push directions['start'].values
    directions['waypoints'].each do |data|
      self.stops.push data
    end
    self.stops.push directions['end'].values
  end

  after_save :refresh_spot_points

  def refresh_spot_points
    spot_points.destroy_all
    saved_points = []

    (stops||[]).each_with_index do |stop, index|
      lat, lng = stop
      saved_points.push spot_points.create! start_at: start_at, lat: lat, lng: lng, position: index
    end


    saved_points.each_with_index do |spot, index|
      spot.update_attributes next_spot_point_ids: saved_points[(index+1)..saved_points.length-1].map(&:id)
    end
  end
end
