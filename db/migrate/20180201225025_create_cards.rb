class CreateCards < ActiveRecord::Migration[5.1]
  def change
    create_table :cards do |t|
      t.integer :category
      t.string :welcome_message
      t.string :message

      t.timestamps
    end
  end
end
