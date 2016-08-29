class AddLikesToPost < ActiveRecord::Migration[5.0]
  def change
  	add_column :posts, :likes, :integer, default: 0
  end
end
