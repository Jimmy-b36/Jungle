class Admin::DashboardController < ApplicationController
  before_filter :authorize

  def show
    @product_count = Product.count()
    @catagories_count = Category.count()
  end
end
