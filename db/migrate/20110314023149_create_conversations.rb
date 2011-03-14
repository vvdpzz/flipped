class CreateConversations < ActiveRecord::Migration
  def self.up
    create_table :conversations do |t|
      t.references :user
      t.integer :participant_id
      t.string :extra_id
      t.string :body

      t.timestamps
    end
    add_index :conversations, [:user_id, :participant_id, :extra_id]
  end

  def self.down
    drop_table :conversations
  end
end
