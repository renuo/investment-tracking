class CreateTimesPerUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :times_per_users do |t|
      t.string :name
      t.integer :ticketId
      t.integer :workedTimes
      t.integer :surplus

      t.timestamps
    end
  end
end
