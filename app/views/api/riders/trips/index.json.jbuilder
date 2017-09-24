json.array! @trips do |trip|
  json.(trip, :id, :start_at, :directions, :stops)
  json.origin_stop [trip.origin_point.lat.to_f, trip.origin_point.lng.to_f]
  json.destination_stop [trip.destination_point.lat.to_f, trip.destination_point.lng.to_f]
end