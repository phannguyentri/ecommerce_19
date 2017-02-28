class Admin::CategoriesController < ApplicationController
  before_action :verify_admin?
  before_action :load_cate, except: [:index, :new, :create]

  def index
    @categories = Category.list_category_desc.paginate page: params[:page],
      per_page: Settings.per_page
  end

  def show
    @subcategories = @category.subcategories.list_subcategory_desc
    .paginate page: params[:page], per_page: Settings.per_page
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new cate_params
    if @category.save
      flash[:success] = t "view.admin.categories.create.success_msg"
      redirect_to admin_categories_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @category.update_attributes cate_params
      flash[:success] = t "view.admin.categories.update.success_msg"
      redirect_to admin_categories_path
    else
      render :edit
    end
  end

  def destroy
    if @category.destroy
      flash[:success] = t "view.admin.categories.destroy.success_msg"
    else
      flash[:danger] = t "view.admin.categories.destroy.error_msg"
    end
    redirect_to admin_categories_path
  end

  private

  def cate_params
    params.require(:category).permit :name
  end

  def load_cate
    @category = Category.find_by id: params[:id]
    return if @category
    flash[:warning] = t "view.admin.categories.not_found"
    redirect_to admin_categories_path
  end
end
