# frozen_string_literal: true

class User
  module Register
    class FindRecord < Micro::Case
      attribute :email

      def call!
        user = User.find_by(email: email)

        if user
          user.regenerate_token
          return Success result: { user: user, email: email }
        end

        Success result: { user: nil, email: email }
      end

      private

      def user_attribute
        { email: email }
      end
    end
  end
end
