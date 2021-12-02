class UserMailer < ApplicationMailer
  def send_token(user)
    @user = user
    mail to: user.email, subject: 'Seu token de acesso ao Challenge Husky'
  end

  def send_invoice(invoice_id)
    @invoice = Invoice.find(invoice_id)
    file_path = Rails.root.join('pdfs', "#{@invoice.identifier}.pdf")
    attachments["#{@invoice.identifier}.pdf"] = File.read(file_path)
    mail to: @invoice.invoice_to_email, subject: "Você acabou de receber uma invoice de #{@invoice.invoice_from}"
  end
end
