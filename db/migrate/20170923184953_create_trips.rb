class CreateTrips < ActiveRecord::Migration[5.1]
  def change
    create_table :trips do |t|
      t.integer :user_id
      t.datetime :start_at
      t.jsonb :directions
      t.jsonb :stops

      t.timestamps
    end

    add_index :trips, :user_id
  end
end
