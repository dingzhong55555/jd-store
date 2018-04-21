class CommentsController < ApplicationController
  def new
    @comment = Comment.new
    @product = Product.find(params[:product_id])
  end

  def create
    @comment = Comment.new(comment_params)
    @product = Product.find(params[:product_id])
    @comment.product = @product
    @comment.user = current_user
    if @comment.save
      redirect_to product_path(@product)
      flash[:notice] = "评论已经发表！"
    else
      redirect_to :back
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
