class ProductsController < ApplicationController
  def index
    @products = Product.all
    @categories = Category.all
  end

  def show_by_category
    @products = Product.where(category_id: params[:id])
    @categories = Category.all
  end
end
