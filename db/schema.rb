# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110314023424) do

  create_table "comments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "tweet_id"
    t.string   "name"
    t.text     "body",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["user_id", "tweet_id"], :name => "index_comments_on_user_id_and_tweet_id"

  create_table "conversations", :force => true do |t|
    t.integer  "user_id"
    t.integer  "participant_id"
    t.string   "extra_id"
    t.string   "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "conversations", ["user_id", "participant_id", "extra_id"], :name => "index_conversations_on_user_id_and_participant_id_and_extra_id"

  create_table "fruits", :force => true do |t|
    t.string "name"
  end

  create_table "locations", :force => true do |t|
    t.integer  "school_id"
    t.string   "name",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "locations", ["school_id"], :name => "index_locations_on_school_id"

  create_table "messages", :force => true do |t|
    t.integer  "user_id"
    t.integer  "conversation_id"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "provinces", :force => true do |t|
    t.string "name"
  end

  create_table "schools", :force => true do |t|
    t.integer  "province_id",  :null => false
    t.string   "name",         :null => false
    t.string   "abbr",         :null => false
    t.integer  "tweets_count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "schools", ["abbr"], :name => "index_schools_on_abbr", :unique => true
  add_index "schools", ["province_id"], :name => "index_schools_on_province_id"

  create_table "tweets", :force => true do |t|
    t.integer  "user_id"
    t.integer  "school_id"
    t.integer  "location_id"
    t.boolean  "gender",         :default => true
    t.string   "hair",                             :null => false
    t.text     "body",                             :null => false
    t.integer  "comments_count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tweets", ["user_id", "school_id", "location_id"], :name => "index_tweets_on_user_id_and_school_id_and_location_id"

  create_table "users", :force => true do |t|
    t.string   "email",                               :default => "", :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "", :null => false
    t.string   "password_salt",                       :default => "", :null => false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
