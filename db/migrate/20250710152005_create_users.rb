class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :password_digest

      t.boolean :hasSeenWelcomeModal, default: false, null: false
      t.integer :coins, default: 10, null: false

      t.timestamps
    end
  end
end
