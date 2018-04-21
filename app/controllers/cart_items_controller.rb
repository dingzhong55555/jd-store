class CartItemsController < ApplicationController
  def destroy
    @cart_item = current_cart.cart_items.find_by(product_id: params[:id])
    @cart_item.destroy
    redirect_to carts_path
    flash[:notice] = "#{@cart_item.product.title}已经删除"
  end

  def add_quantity
    @cart_item = current_cart.cart_items.find_by(product_id: params[:id])
    @cart_item.add!
    @cart_item.save
    redirect_to carts_path
    flash[:notice] = "#{@cart_item.product.title}数量更新为#{@cart_item.quantity}"
  end

  def reduce_quantity
    @cart_item = current_cart.cart_items.find_by(product_id: params[:id])
    if @cart_item.quantity <= 1
      @cart_item.quantity = 1
      redirect_to carts_path
    else
      @cart_item.reduce!
      @cart_item.save
      redirect_to carts_path
      flash[:notice] = "#{@cart_item.product.title}数量更新为#{@cart_item.quantity}"
    end
  end
end
