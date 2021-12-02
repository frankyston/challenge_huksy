# frozen_string_literal: true

class Invoice
  module Mail
    class CreatePdf < Micro::Case
      attributes :invoice

      def call!
        generate_pdf(invoice)
        Success result: { invoice: invoice } if invoice.present?
      rescue ActiveRecord::RecordNotFound
        Failure :error_generate_pdf, result: { message: 'Erro ao gerar o pdf. Favor tente novamente!' }
      end

      def generate_pdf(invoice)
        pdf_html = ActionController::Base.new.render_to_string(pdf: "#{invoice.identifier}.pdf", template: "publics/invoice.pdf", encoding: "UTF-8", locals: { :@invoice => invoice})

        file_path = Rails.root.join('pdfs', "#{invoice.identifier}.pdf")
        File.delete(file_path) if File.exist?(file_path)

        File.open(file_path, 'wb') { |file| file << pdf_html }
      end
    end
  end
end
