class CreateServersTags < ActiveRecord::Migration
  def up
      create_table :servers_tags, :id => false do |t|
      t.integer :server_id, :null => false
      t.integer :tag_id, :null => false
      end

      add_index :servers_tags, [:server_id]
      add_index :servers_tags, [:tag_id]
  end

  def down
      drop_table :servers_tags
  end
end
