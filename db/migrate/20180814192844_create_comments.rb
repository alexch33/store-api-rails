class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.string :author
      t.text :body
      t.float :rating, null: false, default: 0
      t.references :item, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
