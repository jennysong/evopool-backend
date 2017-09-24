class CreateUserRides < ActiveRecord::Migration[5.1]
  def change
    create_table :user_rides do |t|
      t.integer :trip_id
      t.integer :origin_spot_point_id
      t.integer :destination_spot_point_id

      t.timestamps
    end
  end
end
