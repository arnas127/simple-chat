class AddMessagesTable < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.references :user, index: true
      t.text :original_message
      t.text :translated_message

      t.timestamps
    end
  end
end
