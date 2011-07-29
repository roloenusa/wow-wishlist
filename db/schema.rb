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

ActiveRecord::Schema.define(:version => 20110729070157) do

  create_table "characters", :force => true do |t|
    t.integer  "cLastModified"
    t.string   "cName"
    t.string   "cRealm"
    t.integer  "cClass"
    t.integer  "cRace"
    t.integer  "cGender"
    t.integer  "cLevel"
    t.integer  "cAchievementPoints"
    t.string   "cThumbnail"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "characters", ["cName", "cRealm"], :name => "index_characters_on_cName_and_cRealm", :unique => true

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
