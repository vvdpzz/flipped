class CreateFruits < ActiveRecord::Migration
  def self.up
    create_table :fruits do |t|
      t.string :name
    end
  end

  def self.down
    drop_table :fruits
  end
end
