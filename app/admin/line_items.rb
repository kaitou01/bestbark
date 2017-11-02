ActiveAdmin.register LineItem do

  permit_params :quantity, :price, :product_id, :order_id

end
