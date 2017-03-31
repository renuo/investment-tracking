class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.integer :user_id
      t.string :user_name
      t.float :open_investment_time
      t.timestamps
    end
  end
end
