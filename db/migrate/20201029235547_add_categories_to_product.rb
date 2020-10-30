class AddCategoriesToProduct < ActiveRecord::Migration[6.0]
  def change
    add_reference :products, :category, index: true, null: false
  end
end
