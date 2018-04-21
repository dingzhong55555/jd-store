class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  def add!
    quantity = self.quantity + 1
    self.update_columns(quantity: quantity)
  end

  def reduce!
    quantity = self.quantity - 1
    self.update_columns(quantity: quantity)
  end
end
