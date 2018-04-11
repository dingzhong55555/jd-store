class CartsController < ApplicationController
  def checkout
    @order = Order.new
  end

  def clean
    current_cart.clear!
    redirect_to carts_path
    flash[:notice] = "购物车已经清空！"
  end
end
