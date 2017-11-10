class PagesController < ApplicationController
  def about
    @about = Page.first.about
    @categories = Category.all
  end

  def contact
    @contact = Page.first.contact
    @categories = Category.all
  end
end
