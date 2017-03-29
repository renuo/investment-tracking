class CreateImports < ActiveRecord::Migration[5.0]
  def change
    create_table :imports do |t|
      t.string :latest_import

      t.timestamps
    end
  end
end
