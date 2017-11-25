class ChargesController < ApplicationController
  def new
    @amount = (params[:amount].to_f * 100).to_i
    @description = 'Payment'
  end

  def create
    @customer = Stripe::Customer.create(email:  params[:stripeEmail],
                                        source: params[:stripeToken])

    @charge = Stripe::Charge.create(customer:    @customer.id,
                                    amount:      params[:amount].to_i,
                                    description: 'Rails Stripe customer',
                                    currency:    'cad')
    find_customer
    empty_session
  rescue Stripe::CardError
    redirect_to cart_path
  end

  def find_customer
    cust_info = session[:customer_info]
    cust = Customer.where(name: cust_info['name'], address: cust_info['address'],
                          city: cust_info['city'], province_id: cust_info['province'],
                          postal_code: cust_info['postal']).first
    insert_customer(cust, cust_info)
  end

  def insert_customer(cust, cust_info)
    if cust.nil?
      cust = Customer.create(name: cust_info['name'], address: cust_info['address'],
                             city: cust_info['city'], province_id: cust_info['province'],
                             postal_code: cust_info['postal'])
    end
    insert_order(cust)
  end

  def insert_order(cust)
    order = cust.orders.build
    order.status = 'paid'
    order.pst_rate = cust.province.pst
    order.gst_rate = cust.province.gst
    order.hst_rate = cust.province.hst
    order.save
    insert_line_item(order)
  end

  def insert_line_item(order)
    order_items = session[:products_to_buy]
    order_items.each do |o|
      prod = Product.find(o['product']['id'].to_i)

      line_item = order.line_items.build
      line_item.product = prod
      line_item.quantity = o['quantity'].to_i
      line_item.price = prod.price
      line_item.save
    end
  end

  def empty_session
    session[:customer_info] = {}
    session[:products_to_buy] = []
  end
end
