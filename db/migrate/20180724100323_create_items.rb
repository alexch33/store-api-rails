class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :title
      t.text :description
      t.float :rating
      t.float :price

      t.timestamps
    end
  end
end
