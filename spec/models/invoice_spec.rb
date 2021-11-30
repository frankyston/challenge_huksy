# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Invoice, type: :model do
  let(:user) { create(:user) }

  context 'validating required fields' do
    it { should validate_presence_of(:invoice_from) }
    it { should validate_presence_of(:invoice_from_address) }
    it { should validate_presence_of(:invoice_to) }
    it { should validate_presence_of(:invoice_to_email) }
    it { should validate_presence_of(:service_description) }
    it { should validate_presence_of(:currency) }
  end

  it 'object valid with valid attributes' do
    invoice = build(:invoice, user: user)

    expect(invoice).to be_valid
  end

  it 'object invalid' do
    invoice = build(:invoice, user: user)
    invoice.invoice_from = nil

    expect(invoice).to_not be_valid
  end

  it 'new invoice always with status draft' do
    invoice = build(:invoice, user: user)
    expect(invoice.status).to eq('draft')
  end

  context 'When create Invoice' do
    let(:invoice) { build(:invoice, user: user) }
    it 'Before save to database' do
      expect(invoice.identifier).to be_blank
    end

    it 'After save to database' do
      invoice.save
      expect(invoice.identifier).to be_present
    end
  end

  context 'Get all invoices' do
    let!(:draft_list) { create_list(:invoice, 3, status: 0) }
    let!(:sent_list) { create_list(:invoice, 2, status: 1) }

    it 'using scope .draft' do
      expect(Invoice.draft.count).to eq(draft_list.count)
    end

    it 'using scope .draft' do
      expect(Invoice.sent.count).to eq(sent_list.count)
    end
  end
end
