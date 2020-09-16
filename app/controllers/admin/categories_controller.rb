class Admin::CategoriesController < ApplicationController
  before_action :admin_user
  before_action :set_category, only: [:edit, :update, :destroy]

  def index
    @category = Category.new
    @categories = Category.all

  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to admin_categories_path
    else
      @categories = Category.all
      render admin_categories_path
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    if @category.update(category_params)
      redirect_to admin_categories_path
    else
      render edit_admin_category_path
    end
  end

  def destroy
    @category.destroy
    redirect_to admin_categories_path
  end

  private

    def set_category
      @category = Category.find(params[:id])
    end

    def category_params
      params.require(:category).permit(:category_name)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
