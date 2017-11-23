# Controller for the products model
class ProductsController < ApplicationController
  before_action :initialize_session
  before_action :load_shopping_cart, only: [:show, :load_shopping_cart]
  skip_before_action :verify_authenticity_token, only: [:generate_invoice]

  def index
    # @products = Product.order(:name).page(params[:page]).per(5)
    @products = Product.page(params[:page]).per(6).search(params[:search], params[:category])
  end

  def show_by_category
    @products = Product.where(category_id: params[:id])
                .page(params[:page]).per(6)
  end

  def show
    @product = Product.find(params[:id])
  end

  def edit_customer_info
    @provinces = Province.all
  end

  def generate_invoice
    name = params[:name]
    address = params[:address]
    city = params[:city]
    province_id = params[:province].to_i
    postal = params[:postal]

    session[:customer_info] = {name: name, address: address, city: city, province: province_id, postal: postal}
    @province = Province.find(province_id)
    @products_to_buy = session[:products_to_buy]
  end

  def add_to_cart
    id = params[:id].to_i
    quantity = params[:quantity].to_i || 1

    product_hash = {"product" => Product.find(id), "quantity" => quantity}

    session[:products_to_buy] << product_hash unless session[:products_to_buy].any? {|p| p["product"] == Product.find(id)}
    redirect_back fallback_location: root_path, notice: "Successfully added product to cart."
  end

  def remove_item_from_cart
    id = params[:id].to_i
    session[:products_to_buy] = session[:products_to_buy].reject { |p| p["product"]["id"] == id }

    redirect_back fallback_location: root_path, notice: "Item removed."
  end

  def empty_cart
    session[:products_to_buy] = []
    redirect_back fallback_location: root_path, notice: "Cart emptied."
  end

  def update_item
    id = params[:id].to_i
    quantity = params[:quantity].to_i

    session[:products_to_buy].each do |s|
      s["quantity"] = quantity if s["product"]["id"] == id
    end

    redirect_back fallback_location: root_path, notice: "Updated."
  end

  private

  def initialize_session
    session[:products_to_buy] ||= []
  end

  def load_shopping_cart
    @products_to_buy = session[:products_to_buy]
  end
end
