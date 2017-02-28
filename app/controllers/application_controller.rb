class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  def logged_in_user
    unless logged_in?
      flash[:danger] = t "view.users.private.logged_in_user"
      redirect_to login_url
    end
  end

  def correct_user
    @user = User.find_by id: params[:id]
    redirect_to root_path unless @user == current_user
  end
end
