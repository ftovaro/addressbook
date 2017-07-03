class Contact < ApplicationRecord

  def self.list_all_contacts current_api_v1_user
    firebase = Firebase::Client.new(ENV['FIREBASE_URL'])
    response = []
    current_api_v1_user.organizations.ids.each do |id|
      response << firebase.get("organizations/#{id}/contacts").body
    end
    response
  end

  def self.list_organization_contacts org_id
    Firebase::Client.new(ENV['FIREBASE_URL']).get("organizations/#{org_id}/contacts")
  end

  def self.create_contact contact, org_id
    Firebase::Client.new(ENV['FIREBASE_URL']).push("organizations/#{org_id}/contacts",
                                                   format_contact(contact))
  end

  def self.show_contact org_id, contact_id
    Firebase::Client.new(ENV['FIREBASE_URL']).get("organizations/#{org_id}/contacts/#{contact_id}")
  end

  def self.update_contact contact, org_id, contact_id
    firebase = Firebase::Client.new(ENV['FIREBASE_URL'])
    response = firebase.get("organizations/#{org_id}/contacts/#{contact_id}")
    if response.body.nil?
      response.success = false
    else
      firebase.update("organizations/#{org_id}/contacts/#{contact_id}",
                      self.format_contact(contact).delete_if { |k, v| v.empty? })
    end
  end

  def self.delete_contact org_id, contact_id
    Firebase::Client.new(ENV['FIREBASE_URL']).delete("organizations/#{org_id}/contacts/#{contact_id}")
  end

  def self.format_contact contact
    {
      full_name: "#{contact[:full_name]}",
      address: "#{contact[:address]}",
      phone: "#{contact[:phone]}",
      city: "#{contact[:city]}"
    }
  end
end
