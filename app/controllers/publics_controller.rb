# frozen_string_literal: true

class PublicsController < ApplicationController
  layout 'invoice'

  def invoice
    @invoice = Invoice.find_by(identifier: params[:identifier].downcase)
    redirect_to root_path if @invoice.nil?
  end
end
