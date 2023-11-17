# frozen_string_literal: true

class Admin::CategoriesController < Admin::BaseController
  before_action :find_category, only: [:show, :edit, :destroy]
  before_action :find_by_old_slug, only: [:update]

  def index
    if params[:filter]
      filter = FilterService.new(filter_params)
      categories = Kaminari.paginate_array(filter.categories)
    else
      categories = Category.all
    end
    @categories = categories.page(params[:page]).per(5)
  end

  def new
    @category = Category.new
  end

  def create
    category_creator = CategoryCreatorService.new(category_params)
    if category_creator.save
      flash[:notice] = 'Create category success'
      redirect_to admin_categories_url
    else
      @category = category_creator.category
      flash.now[:alert] = 'Create category fail. Please try again'
      render 'new', status: :unprocessable_entity
    end
  end

  def show
    @products = @category.products.page(params[:page]).per(10)
    render 'admin/products/index'
  end

  def edit
  end

  def update
    if @category.update(category_params.except(:old_slug))
      flash[:notice] = 'Update category success'
      redirect_to admin_categories_url
    else
      @category.slug = category_params[:old_slug]
      flash.now[:alert] = 'Update category fail. Please try again'
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    if @category.products.empty?
      @category.destroy
      flash[:notice] = 'Delete category success'
    else
      flash[:alert] = 'Delete category fail because your category has products'
    end
    redirect_to admin_categories_url
  end

  private

  def find_category
    @category = Category.find_by!(slug: params[:slug])
  end

  def find_by_old_slug
    @category = Category.find_by!(slug: params[:category][:old_slug])
  end

  def category_params
    params.require(:category).permit(:name, :shop_id, :slug, :old_slug)
  end

  def filter_params
    params.permit(:name, :slug, :filter)
  end
end
