# Controller for the products model
class ProductsController < ApplicationController
  def index
    @products = Product.all.page(params[:page]).per(5)
    @categories = Category.all
  end

  def show_by_category
    @products = Product.where(category_id: params[:id])
                .page(params[:page]).per(5)
    @categories = Category.all
  end

  def show
    @product = Product.find(params[:id])
    @categories = Category.all
  end
end
