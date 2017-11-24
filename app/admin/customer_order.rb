ActiveAdmin.register_page "CustomerOrder" do
  controller do
    def index
      @customer_order = Customer.all
    end
  end

  content do
    render partial: 'customer_order'
  end
end
