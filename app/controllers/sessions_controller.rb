# frozen_string_literal: true

class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(token: user_params[:token])
    if user
      log_in user
      flash[:notice] = 'Login realizado com sucesso.'
      redirect_to root_path
    else
      flash[:notice] = 'Token inválido. Favor tente novamente ou digite seu e-mail no cadastre-se para receber um novo token por e-mail.'
      render 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:token)
  end
end
