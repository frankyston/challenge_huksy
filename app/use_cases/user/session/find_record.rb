# frozen_string_literal: true

class User
  module Session
    class FindRecord < Micro::Case
      attribute :params

      validates :params, kind: ActionController::Parameters

      def call!
        user = User.find_by(token: user_params[:token])

        if user.present?
          Success result: { user: user, message: 'Login realizado com sucesso.' }
        else
          Failure :invalid_token, result: { message: 'Token inválido. Favor tente novamente ou digite seu e-mail no cadastre-se para receber um novo token por e-mail.' }
        end
      end

      def user_params
        params.require(:user).permit(:token)
      end
    end
  end
end
