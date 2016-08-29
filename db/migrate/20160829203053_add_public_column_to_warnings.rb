class AddPublicColumnToWarnings < ActiveRecord::Migration[5.0]
  def change
  	add_column :warnings, :public, :boolean, default: false
  end
end
