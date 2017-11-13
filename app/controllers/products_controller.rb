# Controller for the products model
class ProductsController < ApplicationController
  def index
    @products = Product.order(:name).page(params[:page]).per(5)
  end

  def show_by_category
    @products = Product.where(category_id: params[:id])
                .page(params[:page]).per(5)
  end

  def show
    @product = Product.find(params[:id])
  end
end
