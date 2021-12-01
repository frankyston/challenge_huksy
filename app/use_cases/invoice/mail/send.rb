# frozen_string_literal: true

class Invoice
  module Mail
    class Send < Micro::Case
      attributes :invoice

      def call!
        if UserMailer.send_invoice(invoice.id).deliver_now
          Success result: { invoice: invoice }
        else
          Failure :failure_send_mail, result: { message: 'Error ao enviar invoice. Favor tente novamente.' }
        end
      end
    end
  end
end
