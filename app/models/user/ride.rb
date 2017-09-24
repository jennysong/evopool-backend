class User::Ride < ApplicationRecord
  belongs_to :trip
  belongs_to :origin_spot_point, class_name: 'Trip::SpotPoint'
  belongs_to :destination_spot_point, class_name: 'Trip::SpotPoint'

  validates :trip, :origin_spot_point, :destination_spot_point, presence: true
end
