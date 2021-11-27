# frozen_string_literal: true

class User
  module Register
    class CreateRecord < Micro::Case
      attributes :user, :email

      def call!
        if user.nil?
          user = User.new(user_attribute)

          return Success result: { user: user, message: 'Usuário criado com sucesso. Verifique seu e-mail que enviamos um token para acessar.' } if user.save

          Failure :invalid_user_params, result: { errors: user.errors }
        else
          Success result: { user: user, message: 'Você já tem cadastro por aqui. Enviamos um e-mail com o seu token de acesso.' }
        end
      end

      private

      def user_attribute
        { email: email }
      end
    end
  end
end
