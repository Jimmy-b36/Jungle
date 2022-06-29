class Admin::CatagoriesController < ApplicationController
  def index
    @catagories = Category.order(id: :desc).all
  end
end
