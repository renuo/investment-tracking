class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.integer :user_id
      t.string :user_name
      t.integer :worked_hours
      t.integer :overflow

      t.timestamps
    end
  end
end
