class Admin::ProductsController < ApplicationController
  before_action :verify_admin?
  before_action :load_product, except: [:index, :new, :create]
  before_action :load_subcategories, only: [:new, :edit]

  def index
    @products = Product.list_products_desc.paginate page: params[:page],
      per_page: Settings.per_page
  end

  def show
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new product_params
    if @product.save
      flash[:success] = t "view.admin.products.create.success_msg"
      redirect_to admin_products_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @product.update_attributes product_params
      flash[:success] = t "view.admin.products.update.success_msg"
      redirect_to admin_products_path
    else
      render :edit
    end
  end

  def show
  end

  def destroy
    if @product.destroy
      flash[:success] = t "view.admin.products.destroy.success_msg"
    else
      flash[:danger] = t "view.admin.products.destroy.error_msg"
    end
    redirect_to admin_products_path
  end

  private

  def product_params
    params.require(:product).permit :name,
      :subcategory_id, :info, :price, :image, :quantity
  end

  def load_product
    @product = Product.find_by id: params[:id]
    return if @product
    flash[:warning] = t "view.admin.products.not_found"
    redirect_to admin_products_path
  end

  def load_subcategories
    @subcategories = Subcategory.all
    return if @subcategories
    flash[:warning] = t "view.admin.products.not_found"
    redirect_to admin_products_path
  end
end
