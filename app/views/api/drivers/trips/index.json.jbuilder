json.array! @trips do |trip|
  json.(trip, :id, :start_at, :directions, :stops)

end