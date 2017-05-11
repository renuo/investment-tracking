class CreateRedmineImports < ActiveRecord::Migration[5.0]
  def change
    create_table :redmine_imports do |t|
      t.string :latest_import

      t.timestamps
    end
  end
end
