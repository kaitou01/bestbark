class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :grab_categories
  def grab_categories
    @categories = Category.all
  end
end
