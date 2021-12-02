# frozen_string_literal: true

class Invoice
  module Mail
    class Flow < Micro::Case
      flow FindInvoice,
           CreatePdf,
           Send,
           UpdateInvoice
    end
  end
end
