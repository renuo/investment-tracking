class RemoveLatestImportFromRedmineImports < ActiveRecord::Migration[5.0]
  def change
    remove_column :redmine_imports, :latest_import
  end
end
