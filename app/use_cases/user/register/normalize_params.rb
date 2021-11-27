# frozen_string_literal: true

class User
  module Register
    class NormalizeParams < Micro::Case
      attribute :params

      validates :params, kind: ActionController::Parameters

      def call!
        user_params

        return Failure :param_email_be_blank, result: { message: 'E-mail be not blank' } if user_params[:email].blank?

        return Failure :invalid_email, result: { message: 'E-mail with invalid format' } unless validate_email(user_params[:email])

        Success result: { email: user_params[:email].downcase }
      end

      def user_params
        params.require(:user).permit(:email)
      end

      private

      def validate_email(email)
        email =~ URI::MailTo::EMAIL_REGEXP
      end
    end
  end
end
