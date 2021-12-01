# frozen_string_literal: true

class Invoice
  class FetchItems < Micro::Case
    attributes :user

    validates :user, kind: User

    def call!
      Success result: { invoices: user.invoices }
    end
  end
end
