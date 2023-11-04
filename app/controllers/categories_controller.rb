# frozen_string_literal: true

class CategoriesController < ApplicationController
  before_action :authenticate_shop!, only: [:index, :new, :create, :edit, :update, :destroy]
  before_action :find_category, only: [:show, :edit, :destroy]
  before_action :find_by_old_slug, only: [:update]

  def index
    @categories = Category.all.page(params[:page]).per(5)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = 'Create category success'
      redirect_to categories_url
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def show
    @products = @category.products.page(params[:page]).per(8)
    redirect_to root_url if @category.nil?
  end

  def edit
  end

  def update
    if @category.update(category_params.except(:old_slug))
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
    @category = Category.find_by(slug: params[:slug])
  end

  def find_by_old_slug
    @category = Category.find_by(slug: params[:category][:old_slug])
  end

  def category_params
    params.require(:category).permit(:name, :shop_id, :slug, :old_slug)
  end
end
