class AddNotNullToNameInOrganization < ActiveRecord::Migration[5.1]
  def change
    change_column_null :organizations, :name, false
  end
end
