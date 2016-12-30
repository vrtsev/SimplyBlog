class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.text :content
      t.belongs_to :user
      t.belongs_to :post
      t.timestamps
    end
  end
end
