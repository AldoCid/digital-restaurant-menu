class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :title
      t.string :description
      t.float :price
      t.references :user

      t.timestamps
    end
  end
end
