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

ActiveRecord::Schema.define(:version => 20110805061829) do

  create_table "characters", :force => true do |t|
    t.integer  "lastmodified"
    t.string   "name"
    t.integer  "klass"
    t.integer  "race"
    t.integer  "gender"
    t.integer  "level"
    t.integer  "achievementpoints"
    t.string   "thumbnail"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "realm_id"
  end

  add_index "characters", ["name"], :name => "index_characters_on_name_and_realm", :unique => true

  create_table "realms", :force => true do |t|
    t.string   "region"
    t.string   "tipe"
    t.boolean  "queue"
    t.boolean  "status"
    t.string   "population"
    t.string   "name"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "realms", ["region", "name"], :name => "index_realms_on_region_and_name", :unique => true

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password"
    t.string   "salt"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

end
