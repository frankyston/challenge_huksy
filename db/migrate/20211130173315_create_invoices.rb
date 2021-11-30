class CreateInvoices < ActiveRecord::Migration[6.1]
  def change
    create_table :invoices do |t|
      t.string :invoice_from
      t.string :invoice_from_address
      t.string :invoice_to
      t.string :invoice_to_email
      t.string :invoice_to_address
      t.string :service_description
      t.integer :currency
      t.decimal :value, precision: 10, scale: 2
      t.integer :status, default: 0
      t.string :identifier
      t.string :number
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
