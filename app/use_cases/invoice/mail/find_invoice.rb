# frozen_string_literal: true

class Invoice
  module Mail
    class FindInvoice < Micro::Case
      attributes :user, :params

      validates :params, kind: ActionController::Parameters

      def call!
        invoice = user.invoices.find(params[:id])
        Success result: { invoice: invoice } if invoice.present?
      rescue ActiveRecord::RecordNotFound
        Failure :invalid_params, result: { message: 'Invoice não encontrada.' }
      end
    end
  end
end
