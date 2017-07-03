class Organization < ApplicationRecord
  has_and_belongs_to_many :users
  validates :name, presence: true

  def assign_user current_api_v1_user
    self.users.push(current_api_v1_user)
  end
end
