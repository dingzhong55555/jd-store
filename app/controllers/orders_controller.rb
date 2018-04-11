class OrdersController < ApplicationController
  def create
    @order = Order.new(order_params)
    @order.user = current_user
    @order.total = current_cart.render_total_price
    if @order.save
      current_cart.cart_items.each do |cart_item|
         product_list = ProductList.new
         product_list.order = @order
         product_list.product_name = cart_item.product.title
         product_list.product_price = cart_item.product.price
         product_list.quantity = cart_item.quantity
         product_list.save
      end
      current_cart.clear!
      OrderMailer.delivery_order_placed(@order).deliver!
      redirect_to order_path(@order.token)
    else
      render "carts/checkout"
    end
  end

  def show
    @order = Order.find_by_token(params[:id])
    @product_lists = @order.product_lists
  end

  def pay_with_alipay
    @order = Order.find_by_token(params[:id])
    @order.pay!
    @order.set_payment_method_with("alipay")
    if @order.save
      redirect_to order_path(@order.token)
      flash[:notice] = "支付宝付款成功"
    else
      render :back
    end
  end

  def pay_with_wechat
    @order = Order.find_by_token(params[:id])
    @order.pay!
    @order.set_payment_method_with("wechat")
    if @order.save
      redirect_to order_path(@order.token)
      flash[:notice] = "微信付款成功"
    else
      render :back
    end
  end

  private

  def order_params
    params.require(:order).permit(:billing_name, :billing_address, :shipping_name, :shipping_address)
  end
end
