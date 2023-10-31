class CategoriesController < ApplicationController
  before_action :find_category, only: [:show, :edit, :update, :destroy]

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    category = Category.new(category_params)
    if category.save
      flash[:notice] = 'Create category success'
      redirect_to categories_url
    else
      flash.now[:alert] = 'Create category fail. Please try again'
      render 'new', status: :unprocessable_entity
    end
  end

  def show
    @category = Category.find(params[:id])
  end

  def edit
  end

  def update
    if @category.update(category_params)
      flash[:notice] = 'Update category success'
      redirect_to categories_url
    else
      flash.now[:alert] = 'Update category fail. Please try again'
      render 'edit'
    end
  end

  def destroy
    @category.destroy
    flash[:notice] = 'Delete category success'
    redirect_to categories_url
  end

  private

  def find_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, :shop_id)
  end
end
