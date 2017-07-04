class Contact < ApplicationRecord

  def self.list_all_contacts current_api_v1_user
    firebase = Firebase::Client.new(ENV['FIREBASE_URL'], ENV['FIREBASE_KEY'])
    response = []
    current_api_v1_user.organizations.ids.each do |id|
      response << firebase.get("contacts", orderBy: '"organization_id"', equalTo: id).body
    end
    response
  end

  def self.list_organization_contacts org_id
    Firebase::Client.new(ENV['FIREBASE_URL'], ENV['FIREBASE_KEY']).
                            get("contacts", orderBy: '"organization_id"', equalTo: org_id)
  end

  def self.create_contact contact, org_id
    Firebase::Client.new(ENV['FIREBASE_URL'], ENV['FIREBASE_KEY']).
                                                  push("contacts", format_contact(contact, org_id))
  end

  def self.show_contact contact_id
    Firebase::Client.new(ENV['FIREBASE_URL'], ENV['FIREBASE_KEY']).get("contacts/#{contact_id}")
  end

  def self.update_contact contact, org_id, contact_id
    firebase = Firebase::Client.new(ENV['FIREBASE_URL'], ENV['FIREBASE_KEY'])
    response = firebase.get("contacts/#{contact_id}")
    if response.body.nil?
      return
    else
      firebase.update("contacts/#{contact_id}",
                      self.format_contact(contact, org_id).delete_if { |k, v| (v.to_s).empty? })
    end
  end

  def self.delete_contact contact_id
    Firebase::Client.new(ENV['FIREBASE_URL'], ENV['FIREBASE_KEY']).delete("contacts/#{contact_id}")
  end

  def self.format_contact contact, org_id
    {
      full_name: "#{contact[:full_name]}",
      address: "#{contact[:address]}",
      phone: "#{contact[:phone]}",
      city: "#{contact[:city]}",
      organization_id: org_id.to_i
    }
  end
end
