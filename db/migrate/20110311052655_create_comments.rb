class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.references :user
      t.references :tweet
      t.string :name
      t.text :body, :null => false
      t.timestamps
    end
    add_index :comments, [:user_id, :tweet_id]
  end

  def self.down
    drop_table :comments
  end
end
