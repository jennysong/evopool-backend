namespace :init do
  task :fake_trips => :environment do
    trips = [{"start":{"lat":49.2488294,"lng":-122.98047220000001},"end":{"lat":49.236996,"lng":-122.95416130000001},"waypoints":[[49.2514695,-122.98905990000003],[49.2546983,-123.00405060000003],[49.2436729,-123.0034159],[49.23158249999999,-123.00355880000001],[49.2298585,-122.98947499999997],[49.2294071,-122.96556290000001]]}]

    trips.each do |trip_attrs|
      trip_attrs['start']

    end

  end
end