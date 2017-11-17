# Controller for the products model
class ProductsController < ApplicationController
  before_action :initialize_session
  before_action :load_shopping_cart, only: [:index, :show]

  def index
    # @products = Product.order(:name).page(params[:page]).per(5)
    @products = Product.page(params[:page]).per(5).search(params[:search], params[:category])
  end

  def show_by_category
    @products = Product.where(category_id: params[:id])
                .page(params[:page]).per(5)
  end

  def show
    @product = Product.find(params[:id])
  end

  def add_to_cart
    id = params[:id].to_i
    session[:products_to_buy] << id unless session[:products_to_buy].include?(id)
    redirect_to product_path(id), notice: "Successfully added product to cart."
  end

  def remove_item_from_cart
    id = params[:id].to_i
    session[:products_to_buy].delete(id)

    redirect_to product_path(id), notice: "Marked Customer As Called"
  end

  def empty_cart
    session[:products_to_buy] = []
    redirect_to root_url, notice: "Cart emptied."
  end

  private

  def initialize_session
    session[:products_to_buy] ||= []
  end

  def load_shopping_cart
    @products_to_buy = Product.find(session[:products_to_buy])
  end
end
