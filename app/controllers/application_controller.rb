class ApplicationController < ActionController::Base
  protected

  def log_in(user)
    session[:token] = user.token
  end

  def authenticate_user
    flash[:notice] = 'Acesso não autorizado.'
    redirect_to root_path unless current_user
  end

  def current_user
    @current_user ||= User.find_by(token: session[:token])
  end
end
