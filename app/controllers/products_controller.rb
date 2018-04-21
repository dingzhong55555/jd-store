class ProductsController < ApplicationController
  before_action :validates_search_key

  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
    @comments = @product.comments
  end

  def add_to_cart
    @product = Product.find(params[:id])
      if current_cart.products.include?(@product)
        redirect_to :back
        flash[:notice] = "#{@product.title}已经在购物车中"
      else
        current_cart.add_product_to_cart(@product)
        redirect_to :back
        flash[:notice] = "已将商品#{@product.title}加入购物车"
      end
  end

  def search
    @products = Product.ransack({:title_or_price_or_description_cont => @q}).result(distinct: true)
  end

  def like
    @product = Product.find(params[:id])
    if current_user.liked_products.include?(@product)
      redirect_to :back
      flash[:notice] = "#{@product.title}已经在收藏夹中"
    else
      current_user.like!(@product)
      redirect_to :back
      flash[:notice] = "已将商品#{@product.title}加入收藏夹"
    end
  end

  def unlike
    @product = Product.find(params[:id])
    @like = current_user.likes.find_by_product_id(@product)
    @like.destroy
    redirect_to :back
    flash[:notice] = "已将商品#{@product.title}移除收藏夹"
  end

  protected

  def validates_search_key
    @q = params[:query_string].gsub(/\|\'|\/|\?/, "") if params[:query_string].present?
  end
end
