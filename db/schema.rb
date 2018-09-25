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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2018_09_07_134013) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string "house_number"
    t.string "sitio"
    t.string "barangay"
    t.string "municipality"
    t.string "province"
    t.bigint "user_id"
    t.bigint "guardian_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["guardian_id"], name: "index_addresses_on_guardian_id"
    t.index ["user_id"], name: "index_addresses_on_user_id"
  end

  create_table "courses", force: :cascade do |t|
    t.string "name"
    t.string "abbreviation"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "guardians", force: :cascade do |t|
    t.string "first_name"
    t.string "middle_name"
    t.string "last_name"
    t.string "mobile"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "opennings", force: :cascade do |t|
    t.datetime "openning_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "profile_photos", force: :cascade do |t|
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "avatar_file_name"
    t.string "avatar_content_type"
    t.integer "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.index ["user_id"], name: "index_profile_photos_on_user_id"
  end

  create_table "relationships", force: :cascade do |t|
    t.bigint "guardian_id"
    t.bigint "user_id"
    t.string "relation"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["guardian_id"], name: "index_relationships_on_guardian_id"
    t.index ["user_id"], name: "index_relationships_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "id_number"
    t.bigint "course_id"
    t.bigint "year_level_id"
    t.string "first_name"
    t.string "middle_name"
    t.string "last_name"
    t.string "email", default: "", null: false
    t.integer "gender"
    t.datetime "birthdate"
    t.string "mobile"
    t.integer "tag_uid"
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "join_date"
    t.string "full_name"
    t.string "type"
    t.integer "role"
    t.integer "status", default: 0
    t.index ["course_id"], name: "index_users_on_course_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["type"], name: "index_users_on_type"
    t.index ["year_level_id"], name: "index_users_on_year_level_id"
  end

  create_table "year_levels", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "addresses", "guardians"
  add_foreign_key "addresses", "users"
  add_foreign_key "profile_photos", "users"
  add_foreign_key "relationships", "guardians"
  add_foreign_key "relationships", "users"
  add_foreign_key "users", "courses"
  add_foreign_key "users", "year_levels"
end
