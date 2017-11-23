class ChargesController < ApplicationController
  def new
    @amount = (params[:amount].to_f * 100).to_i
    @description = 'Description of Charge'
  end

  def create
    amount = params[:amount].to_i
    cust_info = session[:customer_info]
    order_items = session[:products_to_buy]

    @customer = Stripe::Customer.create(email:  params[:stripeEmail],
                                       source: params[:stripeToken])

    @charge = Stripe::Charge.create(customer:    @customer.id,
                                    amount:      amount,
                                    description: 'Rails Stripe customer',
                                    currency:    'cad')

    cust = Customer.where(name: cust_info["name"],
                          address: cust_info["address"],
                          city: cust_info["city"],
                          province_id: cust_info["province"],
                          postal_code: cust_info["postal"]).first

    if cust.nil?
      cust = Customer.create(name: cust_info["name"],
                             address: cust_info["address"],
                             city: cust_info["city"],
                             province_id: cust_info["province"],
                             postal_code: cust_info["postal"])
    end

    order = cust.orders.build
    order.status = 'paid'
    order.pst_rate = cust.province.pst
    order.gst_rate = cust.province.gst
    order.hst_rate = cust.province.hst
    order.save

    order_items.each do |o|
      prod = Product.find(o["product"]["id"].to_i)

      line_item = order.line_items.build
      line_item.product = prod
      line_item.quantity = o["quantity"].to_i
      line_item.price = prod.price
      line_item.save
    end

    session[:products_to_buy] = []
    session[:customer_info] = {}

    rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path(amount: (amount /100.0))
  end
end
