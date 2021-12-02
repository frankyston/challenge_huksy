# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PublicsController, type: :controller do
  context '#invoice' do
    it 'should at render invoice' do
      invoice = create(:invoice)
      get :invoice, params: { identifier: invoice.identifier }
      expect(subject).to render_template(:invoice)
      expect(assigns(:invoice)).not_to be_nil
    end

    it 'should at assign @invoices' do
      get :invoice, params: { identifier: 999 }
      expect(response).to redirect_to(root_path)
    end
  end
end
