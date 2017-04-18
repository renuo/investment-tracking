class CreateEmployees < ActiveRecord::Migration[5.0]
  def change
    create_table :employees do |t|
      t.integer :employee_id
      t.string :employee_name
      t.float :open_investment_time
      t.timestamps
    end
  end
end
