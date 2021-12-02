# frozen_string_literal: true

class Invoice
  class FetchItems < Micro::Case
    attributes :user, :params

    validates :user, kind: User
    validates :params, kind: ActionController::Parameters

    def call!
      invoices = user.invoices
      if params[:invoice].present?
        invoices = invoices.where(number: invoice_params[:number]) if invoice_params[:number].present?
        invoices = invoices.where(created_at: ranged_date(invoice_params[:created_at])) if invoice_params[:created_at].present?
      end
      Success result: { invoices: invoices }
    end

    private
    def invoice_params
      params.require(:invoice).permit(:number, :created_at)
    end

    def ranged_date(date)
      date.to_date.beginning_of_day..date.to_date.end_of_day
    end
  end
end
