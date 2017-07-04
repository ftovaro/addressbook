class ContactMailer < ApplicationMailer
  def report_email attachment, document_name, email, subject
    attachments[document_name] = { mime_type: Mime[:xlsx], content: attachment }
    mail(to: [email.split(",").map(&:strip)], subject: subject)
  end
end
