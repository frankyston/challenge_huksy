# frozen_string_literal: true

class RegistrationsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: user_params[:email].downcase)
    if user
      user.regenerate_token
      flash[:notice] = 'Você já tem cadastro por aqui. Enviamos um e-mail com o seu token de acesso.'
    else
      user = User.create(email: user_params[:email].downcase)

      flash[:notice] = 'Usuário criado com sucesso. Verifique seu e-mail que enviamos um token para acessar.'
    end
    # enviar o e-mail
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:email)
  end
end
