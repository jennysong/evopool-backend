class Trip::SpotPoint < ApplicationRecord
  reverse_geocoded_by :lat, :lng
end
