# frozen_string_literal: true

class Invoice
  class AddItem < Micro::Case
    attributes :user, :params

    validates :user, kind: User
    validates :params, kind: ActionController::Parameters

    def call!
      invoice = user.invoices.create(invoice_params)

      return Success result: { invoice: invoice } if invoice.persisted?

      Failure :invoice_invalid, result: { invoice: invoice, errors: invoice.errors.full_messages.join(', ') }
    rescue ActionController::ParameterMissing => e
      Failure :parameter_missing, result: { message: 'Parametro invoice não enviada.' }
    end

    private

    def invoice_params
      params.require(:invoice).permit(:invoice_from, :invoice_from_address, :invoice_to, :invoice_to_email,
                                      :invoice_to_address, :service_description, :currency, :value, :status,
                                      :identifier, :number)
    end
  end
end
