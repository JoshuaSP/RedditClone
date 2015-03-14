class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :parent_id, index: true
      t.references :post, null: false, index: true
      t.integer :author_id, null: false, index: true
      t.text :content

      t.timestamps null: false
    end
    add_foreign_key :comments, :posts
  end
end
