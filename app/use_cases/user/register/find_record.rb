# frozen_string_literal: true

class User
  module Register
    class FindRecord < Micro::Case
      attribute :email

      def call!
        user = User.find_by(email: email)

        if user.present?
          user.regenerate_token
          Success result: { user: user, email: email }
        else
          Success result: { user: nil, email: email }
        end
      end
    end
  end
end
