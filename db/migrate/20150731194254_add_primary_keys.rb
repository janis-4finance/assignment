class AddPrimaryKeys < ActiveRecord::Migration
  def change
    execute "ALTER TABLE loans ADD PRIMARY KEY (uuid)"
    execute "ALTER TABLE users ADD PRIMARY KEY (uuid)"
  end
end
