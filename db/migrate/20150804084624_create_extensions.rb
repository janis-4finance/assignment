class CreateExtensions < ActiveRecord::Migration
  def change
    create_table :extensions, id: false do |t|
      t.string  :uuid, primary_key: true, limit: 36
      t.string :loan_id, limit: 36
      t.integer :days
      t.decimal :apr,      precision: 8, scale: 4
      t.decimal :interest, precision: 8, scale: 2
      t.decimal :total,    precision: 8, scale: 2
      t.timestamps null: false
    end
  end
end
