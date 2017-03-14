class Admin::SuggestsController < ApplicationController
  before_action :verify_admin?
  before_action :load_suggest, only: [:edit, :update]

  def index
    @suggests = current_user.suggests.newest.paginate page: params[:page],
      per_page: Settings.per_page
  end

  def edit
  end

  def update
    if @suggest.update_attributes suggest_params
      flash[:success] = t "view.admin.suggests.update.success_msg"
      redirect_to suggests_path
    else
      render :edit
    end
  end

  private

  def load_subcategories
    @subcategories = Subcategory.all
    return if @subcategories
    flash[:warning] = t "view.admin.suggests.not_found"
    redirect_to root_path
  end

  def suggest_params
    params.require(:suggest).permit :status
  end

  def load_suggest
    @suggest = Suggest.find_by id: params[:id]
    return if @suggest
    flash[:warning] = t "view.admin.suggests.not_found_suggest"
    redirect_to :back
  end
end
