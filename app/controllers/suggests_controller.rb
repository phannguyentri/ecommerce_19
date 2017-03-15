class SuggestsController < ApplicationController
  before_action :logged_in_user correct_suggest_user
  before_action :correct_suggest_user, only: [:edit, :update, :destroy]
  before_action :load_suggest, only: [:edit, :update, :destroy]
  before_action :check_status, only: [:edit, :update, :destroy]
  before_action :load_subcategories, only: [:new, :edit, :update]

  def index
    @suggests = current_user.suggests.newest.paginate page: params[:page],
      per_page: Settings.per_page
  end

  def new
    @suggest = Suggest.new
  end

  def create
    @suggest = current_user.suggests.new suggest_params
    if @suggest.save
      flash[:success] = t "view.suggests.create.success_msg"
      redirect_to suggests_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @suggest.update_attributes suggest_params
      flash[:success] = t "view.suggests.update.success_msg"
      redirect_to suggests_path
    else
      render :edit
    end
  end

  def destroy
    if @suggest.destroy
      flash[:success] = t "view.suggests.destroy.success_msg"
    else
      flash[:danger] = t "view.suggests.destroy.fail_msg"
    end
    redirect_to :back
  end

  private

  def load_subcategories
    @subcategories = Subcategory.all
    return if @subcategories
    flash[:warning] = t "view.suggests.not_found_sub"
    redirect_to root_path
  end

  def suggest_params
    params.require(:suggest).permit :name, :subcategory_id, :status
  end

  def check_status
    return if @suggest.pending?
    flash[:warning] = t "view.suggests.cant_modify"
    redirect_to suggests_path
  end

  def load_suggest
    @suggest = Suggest.find_by id: params[:id]
    return if @suggest
    flash[:warning] = t "view.suggests.not_found_suggest"
    redirect_to :back
  end
end
