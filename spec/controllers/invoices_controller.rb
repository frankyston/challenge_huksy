# frozen_string_literal: true

require 'rails_helper'

RSpec.describe InvoicesController, type: :controller do
  let!(:user) { create(:user) }
  before do
    session[:token] = user.token
  end

  context '#index' do
    context 'with invoices' do
      let!(:invoices) { create_list(:invoice, 3, user: user) }
      it 'should at assign @invoices' do
        get :index
        expect(subject).to render_template(:index)
        expect(assigns(:invoices)).not_to be_nil
      end
    end

    context 'without invoices' do
      it 'should at assign @invoices' do
        get :index
        expect(subject).to render_template(:index)
        expect(assigns(:invoices)).to eq []
      end
    end
  end

  context '#create' do
    context 'parameter_missing' do
      let(:params) { { invoice: {} } }
      it 'should error parameter missing' do
        post :create, params: params
        expect(flash[:notice]).to be_present
        expect(flash[:notice]).to match(/Parametro invoice não enviada.*/)
        expect(subject).to render_template(:new)
      end
    end

    context 'invoice_invalid' do
      let(:invoice) { build(:invoice) }
      it 'should error invoice with invalid values' do
        invoice.invoice_from = nil
        params = { invoice: invoice.attributes }

        post :create, params: params
        expect(flash[:notice]).to be_present
        expect(flash[:notice]).to match(/Invoice from can't be blank*/)
        expect(subject).to render_template(:new)
      end
    end

    context 'success create invoice' do
      let(:invoice) { build(:invoice) }
      it 'should redirect to invoices_path' do
        params = { invoice: invoice.attributes }

        post :create, params: params
        expect(flash[:notice]).to be_present
        expect(flash[:notice]).to match(/Invoice criada com sucesso.*/)
        expect(Invoice.count).to eq(1)
        expect(response).to redirect_to(invoices_path)
      end
    end
  end
end
