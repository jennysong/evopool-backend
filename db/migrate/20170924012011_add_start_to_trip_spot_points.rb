class AddStartToTripSpotPoints < ActiveRecord::Migration[5.1]
  def change
    add_column :trip_spot_points, :start_at, :datetime
    add_index :trip_spot_points, :start_at
  end
end
