class AddReferencesToUploads < ActiveRecord::Migration[5.2]
  def change
    add_reference :uploads, :item, foreign_key: true
  end
end
