class Contact::ContactSender
  def self.send_email contacts, email
    file = Contact::ContactSender.create_file contacts
    ContactMailer.report_email(file.to_stream.read, "Contacts", email, "Welcome to Google!").deliver_now
  end
  def self.create_file contacts
    excel = Axlsx::Package.new
    excel.workbook.add_worksheet(name: "Contacts") do |sheet|
      sheet.add_row(["ID", "Full name", "Address", "Phone", "City", "Organization"])
      contacts.each do |contact|
        sheet.add_row([
          contact["id"],
          contact["full_name"],
          contact["address"],
          contact["phone"],
          contact["city"],
          Organization.find(contact["organization_id"]).name
        ])
      end
    end
    excel.use_shared_strings = true
    excel
  end
end
