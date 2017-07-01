class Organization < ApplicationRecord
  has_and_belongs_to_many :users
  validates :name, presence: true
  after_create :init_firebase_slot

  private
  def init_firebase_slot
    firebase = Firebase::Client.new(ENV['firebase_url'])
    response = firebase.push("organizations/#{id}", { name: "#{name}" })
    if response.success?
      self.firebase_id = response.body["name"]
      self.save
    else
      #TODO Indicate user organization couldn't be saved
    end
  end
end
