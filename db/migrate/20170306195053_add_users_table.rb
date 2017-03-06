class AddUsersTable < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :dialect

      t.timestamps
    end
  end
end
