ActiveAdmin.register Product do

    permit_params :name, :description, :price, :quantity

end
