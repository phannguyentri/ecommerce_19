module SessionsHelper
  def log_in user
    session[:user_id] = user.id
  end

  def current_user
    @current_user ||= User.find_by id: session[:user_id]
  end

  def logged_in?
    !current_user.nil?
  end

  def log_out
    session.delete :user_id
    @current_user = nil
  end

  def verify_admin?
    if !current_user.nil?
      redirect_to root_path unless current_user.is_admin?
    else
      redirect_to root_path
    end
  end

  def is_admin?
    if !current_user.nil?
      current_user.is_admin?
    else
      return false
    end
  end
end
