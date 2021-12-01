# frozen_string_literal: true

class Invoice
  module Mail
    class UpdateInvoice < Micro::Case
      attributes :invoice

      def call!
        invoice.sent!
        Success result: { message: 'Invoice envida com sucesso.' }
      end
    end
  end
end
