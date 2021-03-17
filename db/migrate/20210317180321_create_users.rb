class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :uid
      t.jsonb :credentials
      t.string :token
      t.integer :lock_version, defailt: 0

      t.timestamps
    end
    add_index :users, :name, unique: true
    add_index :users, :uid, unique: true
    add_index :users, :token, unique: true
  end
end
