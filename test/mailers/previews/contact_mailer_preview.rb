class ContactMailerPreview < ActionMailer::Preview
  def report_email
    contacts = Contact.list_all_contacts User.first
    file = Contact::ContactSender.create_file contacts
    ContactMailer.report_email file.to_stream.read, "Contacts", 'f.tovar12@gmail.com', "Here you have your contacts!"
  end
end
