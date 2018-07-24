class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :mail
      t.string :password
      t.string :role, array: true
      t.string :nick

      t.timestamps
    end
  end
end
