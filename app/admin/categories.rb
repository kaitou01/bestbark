ActiveAdmin.register Category do

  permit_params :name, :description, :price, :quantity

end
