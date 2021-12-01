# frozen_string_literal: true

class Invoice < ApplicationRecord
  belongs_to :user

  enum status: { draft: 0, sent: 1 }
  enum currency: { usd: 0, brl: 1, eur: 2, aud: 3, cad: 4, gbp: 5, chf: 6,
                   aed: 7, clp: 8, nok: 9, jpy: 10, ars: 11, sgd: 12, nzd: 13,
                   sek: 14, dkk: 15 }
  validates :invoice_from, :invoice_from_address, :invoice_to, :invoice_to_email,
            :service_description, :value, :currency, presence: true
  before_create :generate_identifier

  scope :draft, -> { where(status: 0) }
  scope :sent, -> { where(status: 1) }

  private

  def generate_identifier
    self.identifier = SecureRandom.uuid
  end
end
