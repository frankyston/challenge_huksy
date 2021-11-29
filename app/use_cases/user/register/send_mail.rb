# frozen_string_literal: true

class User
  module Register
    class SendMail < Micro::Case
      attributes :user, :message

      def call!
        mail = UserMailer.send_token(user).deliver_now

        return Success result: { message: message } if mail.errors.empty?

        Failure :error_send_mail, result: { message: 'Erro ao enviar o e-mail, favor tente novamente.' }
      end
    end
  end
end
