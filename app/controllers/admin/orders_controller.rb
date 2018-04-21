class Admin::OrdersController < ApplicationController
  layout "admin"
  before_action :require_is_admin!
  before_action :authenticate_user!

  def index
    @orders = Order.order("id desc")
  end

  def show
    @order = Order.find(params[:id])
    @product_lists = @order.product_lists
  end
end
