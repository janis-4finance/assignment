class FixSchema < ActiveRecord::Migration
  def change
    # schema.rb skips primary key definitions and rails defaults to INT - this breaks environment
    # when db needs to be recreated
    add_column :users, :new_uuid, :string, :limit => 36, :after => :uuid
    add_column :loans, :new_uuid, :string, :limit => 36, :after => :uuid
    remove_column :users, :uuid, :string
    remove_column :loans, :uuid, :string
    rename_column :users, :new_uuid, :uuid
    rename_column :loans, :new_uuid, :uuid
  end
end
