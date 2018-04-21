class Admin::ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_id_admin!

  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to admin_products_path
      flash[:notice] = "新增商品#{@product.title}"
    else
      render :new
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to admin_products_path
    flash[:notice] = "#{@product.title}已经删除！"
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      redirect_to admin_products_path
      flash[:notice] = "数据已经更新"
    else
      render :edit
    end
  end

  def require_id_admin!
    if !current_user.is_admin?
      redirect_to "/"
      flash[:notice] = "You have no permission!"
    end
  end

  # def delete
  #   @product = Product.find(params{:id})
  #   @product.destroy
  #   render :index
  # end

  private

  def product_params
    params.require(:product).permit(:title, :description, :quantity, :price, :image)
  end

end
