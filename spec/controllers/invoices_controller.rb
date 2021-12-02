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

    context 'Filters' do
      context 'by number' do
        it 'should one invoice' do
          create_list(:invoice, 3, user: user)
          params = { invoice: { number: Invoice.first.number } }
          get :index, params: params
          expect(assigns(:invoices).count).to eq(1)
        end
      end

      context 'by date' do
        before do
          create_list(:invoice, 3, user: user)
        end

        it 'should two invoice' do
          invoice1 = create(:invoice, created_at: 2.days.ago, user: user)
          invoice2 = create(:invoice, created_at: 2.days.ago, user: user)
          params = { invoice: { created_at: invoice1.created_at.to_date.to_s } }
          get :index, params: params
          expect(assigns(:invoices).count).to eq(2)
        end

        it 'should three invoices' do
          params = { invoice: { created_at: Date.today.to_s } }
          get :index, params: params
          expect(assigns(:invoices).count).to eq(3)
        end
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
        expect(flash[:notice]).to eq('Quem é você? não pode ficar em branco')
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

  context '#send_invoice' do
    let(:user) { create(:user) }
    it 'should error invalid_params' do
      get :send_invoice, params: { id: 999 }
      expect(flash[:notice]).to be_present
      expect(flash[:notice]).to match(/Invoice não encontrada.*/)
    end

    it 'should send invoice' do
      invoice = create(:invoice, user: user)
      get :send_invoice, params: { id: invoice.id }
      expect(flash[:notice]).to be_present
      expect(flash[:notice]).to match(/Invoice envida com sucesso.*/)
    end
  end
end
