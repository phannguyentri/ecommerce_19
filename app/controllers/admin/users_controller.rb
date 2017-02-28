class Admin::UsersController < ApplicationController
  before_action :verify_admin?
  before_action :load_user, except: [:index, :new, :create]

  def index
    @users = User.paginate page: params[:page],per_page: Settings.per_page
  end

  def edit
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "view.admin.users.update.success_msg"
      redirect_to admin_users_path
    else
      flash[:danger] = t "view.admin.users.update.error_msg"
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t "view.admin.users.destroy.success_msg"
    else
      flash[:danger] = t "view.admin.users.destroy.error_msg"
    end
    redirect_to admin_users_path
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password, :address,
      :phone, :password_confirmation
  end

  def load_user
    @user = User.find_by id: params[:id]
    unless @user
      flash[:warning] = t "view.admin.users.not_found"
      redirect_to admin_users_path
    end
  end
end
