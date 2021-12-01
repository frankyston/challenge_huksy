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
end
