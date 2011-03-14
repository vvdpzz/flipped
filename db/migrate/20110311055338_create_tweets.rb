class CreateTweets < ActiveRecord::Migration
  def self.up
    create_table :tweets do |t|
      t.references :user
      t.references :school
      t.references :location
      t.boolean :gender, :default => true
      t.string :hair, :null => false
      t.text :flirt, :null => false
      t.integer :comments_count

      t.timestamps
    end
    add_index :tweets, [:user_id, :school_id, :location_id]
  end

  def self.down
    drop_table :tweets
  end
end
