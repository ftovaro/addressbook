class AddFirebaseIdToOrganizations < ActiveRecord::Migration[5.1]
  def change
    add_column :organizations, :firebase_id, :string
  end
end
