class Admin::SubcategoriesController < ApplicationController
  before_action :verify_admin?
  before_action :load_sub, except: [:index, :new, :create]
  before_action :load_categories, only: [:new, :edit]

  def index
    @subcategories = Subcategory.list_subcategory_desc
    .paginate page: params[:page], per_page: Settings.per_page
  end

  def new
    @subcategory = Subcategory.new
  end

  def create
    @subcategory = Subcategory.new sub_params
    if @subcategory.save
      flash[:success] = t "view.admin.subcategories.create.success_msg"
      redirect_to admin_subcategories_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @subcategory.update_attributes sub_params
      flash[:success] = t "view.admin.subcategories.update.success_msg"
      redirect_to admin_subcategories_path
    else
      render :edit
    end
  end

  def destroy
    if @subcategory.destroy
      flash[:success] = t "view.admin.categories.destroy.success_msg"
    else
      flash[:danger] = t "view.admin.categories.destroy.error_msg"
    end
    redirect_to admin_subcategories_path
  end

  def sub_params
    params.require(:subcategory).permit :name, :category_id
  end

  def load_sub
    @subcategory = Subcategory.find_by id: params[:id]
    return if @subcategory
    flash[:warning] = t "view.admin.subcategories.not_found"
    redirect_to admin_subcategories_path
  end

  def load_categories
    @categories = Category.all
    return if @categories
    flash[:warning] = t "view.admin.categories.not_found"
    redirect_to admin_subcategories_path
  end
end
