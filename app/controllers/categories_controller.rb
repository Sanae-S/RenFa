class CategoriesController < ApplicationController
  before_action :authenticate_user!

  def index
  	@categories = Category.all

  end

  private

    def set_category
      @category = Category.find(params[:id])
    end

    def category_params
      params.require(:category).permit(:category_name)
    end
end
