class Admin::DashboardController < ApplicationController
  def show
    @product_count = Product.count()
    @catagories_count = Category.count()
  end
end
