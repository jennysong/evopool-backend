class CreateTripSpotPoints < ActiveRecord::Migration[5.1]
  def change
    create_table :trip_spot_points do |t|
      t.integer :trip_id
      t.decimal :lat
      t.decimal :lng
      t.integer :next_spot_point_ids, array: true
      t.integer :position
      t.string :address

      t.timestamps
    end

    add_index :trip_spot_points, :trip_id
  end
end
