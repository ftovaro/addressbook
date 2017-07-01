class User < ActiveRecord::Base
  has_and_belongs_to_many :organizations
  rolify
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User

  after_create :assign_default_role

  def assign_default_role
    self.add_role(:regular)
  end

end
