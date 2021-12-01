# frozen_string_literal: true

class InvoicesController < ApplicationController
  before_action :authenticate_user

  def index
    Invoice::FetchItems
      .call(user: current_user)
      .on_success { |result| @invoices = result[:invoices] }
  end
end
