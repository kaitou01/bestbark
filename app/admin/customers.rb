ActiveAdmin.register Customer do

    permit_params :name, :username, :password, :address, :city, :postal_code

end
