class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users, id: false do |t|
      t.string :uuid, :primary_key => true, :limit => 36
      t.string :name
      t.string :phone
      t.string :iban

      t.timestamps null: false
    end
    add_index :users, :iban, :unique => true
  end
end
