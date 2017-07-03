class Organization < ApplicationRecord
  has_and_belongs_to_many :users
  validates :name, presence: true
  after_create :init_firebase_slot

  def update_firebase_slot
    Firebase::Client.new(ENV['FIREBASE_URL']).update("organizations/#{id}", { name: "#{name}" })
  end

  def delete_firebase_slot
    Firebase::Client.new(ENV['FIREBASE_URL']).delete("organizations/#{id}")
  end

  def assign_user current_api_v1_user
    self.users.push(current_api_v1_user)
  end

  private
  def init_firebase_slot
    Firebase::Client.new(ENV['FIREBASE_URL']).set("organizations/#{id}", { name: "#{name}" })
  end
end
