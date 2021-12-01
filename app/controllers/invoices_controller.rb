# frozen_string_literal: true

class InvoicesController < ApplicationController
  before_action :authenticate_user

  def index
    Invoice::FetchItems
      .call(user: current_user)
      .on_success { |result| @invoices = result[:invoices] }
  end

  def new
    @invoice = current_user.invoices.new
    @invoice.number = Time.zone.now.strftime('%Y%d%m%H%M')
  end

  def create
    Invoice::AddItem
      .call(user: current_user, params: params)
      .on_failure(:parameter_missing) { |error| error_invoice(error[:message], 'new') }
      .on_failure(:invoice_invalid) do |result|
        @invoice = result[:invoice]
        error_invoice(result[:errors], 'new')
      end
      .on_success do |result|
        flash[:notice] = 'Invoice criada com sucesso.'
        redirect_to invoices_path
      end
  end

  def send_invoice
    Invoice::Mail::Flow
      .call(user: current_user, params: params)
      .on_failure(:invalid_params) { |error| flash_and_redirect_mail(error[:message]) }
      .on_failure(:failure_send_mail) { |error| flash_and_redirect_mail(error[:message]) }
      .on_success { |result| flash_and_redirect_mail(result[:message]) }
  end

  private

  def error_invoice(error, view)
    flash[:notice] = error
    render view
  end

  def flash_and_redirect_mail(error)
    flash[:notice] = error
    redirect_to invoices_path
  end
end
