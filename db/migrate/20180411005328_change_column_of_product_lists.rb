class ChangeColumnOfProductLists < ActiveRecord::Migration[5.0]
  def change
    change_column :product_lists, :product_price, :integer
  end
end
