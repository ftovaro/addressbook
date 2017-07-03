class Organization < ApplicationRecord
  has_and_belongs_to_many :users
  validates :name, presence: true
  after_create :init_firebase_slot, :assign_user

  def update_firebase_slot
    firebase = Firebase::Client.new(ENV['FIREBASE_URL'])
    firebase.update("organizations/#{id}", { name: "#{name}" })
  end

  def self.delete_firebase_slot
    firebase = Firebase::Client.new(ENV['FIREBASE_URL'])
    firebase.delete("organizations/#{id}")
  end

  private
  def init_firebase_slot
    firebase = Firebase::Client.new(ENV['FIREBASE_URL'])
    firebase.set("organizations/#{id}", { name: "#{name}" })
  end

  def assign_user
    self.users = current_api_v1_user
  end
end
