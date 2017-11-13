class PagesController < ApplicationController
  def about
    @about = Page.first.about
  end

  def contact
    @contact = Page.first.contact
  end
end
