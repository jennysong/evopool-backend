json.(ride, :id)

json.trip do
  json.(ride.trip, :id, :start_at, :directions, :stops)
end

json.origin_stop do
  json.(ride.origin_spot_point, :id, :start_at, :lat, :lng)
end

json.destination_stop do
  json.(ride.destination_spot_point, :id, :start_at, :lat, :lng)
end