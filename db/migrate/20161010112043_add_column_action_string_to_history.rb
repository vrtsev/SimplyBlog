class AddColumnActionStringToHistory < ActiveRecord::Migration[5.0]
  def change
  	add_column :histories, :action, :string
  end
end
