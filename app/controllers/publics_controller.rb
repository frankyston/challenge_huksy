# frozen_string_literal: true

class PublicsController < ApplicationController
  layout 'invoice'

  def invoice
    @invoice = Invoice.find_by(identifier: params[:identifier].downcase)
    redirect_to root_path if @invoice.nil?
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: @invoice.identifier, encoding: 'utf8'
      end
    end
  end
end
