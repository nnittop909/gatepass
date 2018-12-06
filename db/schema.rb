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

ActiveRecord::Schema.define(version: 2018_12_05_134801) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "addresses", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "house_number"
    t.string "sitio"
    t.string "barangay"
    t.string "municipality"
    t.string "province"
    t.uuid "user_id"
    t.uuid "guardian_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["guardian_id"], name: "index_addresses_on_guardian_id"
    t.index ["user_id"], name: "index_addresses_on_user_id"
  end

  create_table "configurations", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.integer "display_time"
    t.datetime "deployment_date"
    t.datetime "subscription_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "course_durations", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.decimal "duration"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "courses", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "abbreviation"
    t.uuid "course_duration_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_duration_id"], name: "index_courses_on_course_duration_id"
  end

  create_table "guardians", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "first_name"
    t.string "middle_name"
    t.string "last_name"
    t.string "mobile"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "logs", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "remark"
    t.datetime "log_time"
    t.uuid "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_logs_on_user_id"
  end

  create_table "positions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "title"
    t.uuid "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_positions_on_user_id"
  end

  create_table "profile_photos", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "avatar_file_name"
    t.string "avatar_content_type"
    t.integer "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.index ["user_id"], name: "index_profile_photos_on_user_id"
  end

  create_table "relationships", force: :cascade do |t|
    t.uuid "guardian_id"
    t.uuid "user_id"
    t.string "relation"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["guardian_id"], name: "index_relationships_on_guardian_id"
    t.index ["user_id"], name: "index_relationships_on_user_id"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "id_number"
    t.uuid "course_id"
    t.uuid "year_level_id"
    t.string "first_name"
    t.string "middle_name"
    t.string "last_name"
    t.string "email", default: "", null: false
    t.integer "gender"
    t.datetime "birthdate"
    t.string "mobile"
    t.bigint "rfid_uid"
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.date "join_date"
    t.string "full_name"
    t.string "type"
    t.integer "role"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_users_on_course_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["id_number"], name: "index_users_on_id_number", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["rfid_uid"], name: "index_users_on_rfid_uid", unique: true
    t.index ["type"], name: "index_users_on_type"
    t.index ["year_level_id"], name: "index_users_on_year_level_id"
  end

  create_table "year_levels", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.integer "level"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "addresses", "guardians"
  add_foreign_key "addresses", "users"
  add_foreign_key "courses", "course_durations"
  add_foreign_key "logs", "users"
  add_foreign_key "positions", "users"
  add_foreign_key "profile_photos", "users"
  add_foreign_key "relationships", "guardians"
  add_foreign_key "relationships", "users"
  add_foreign_key "users", "courses"
  add_foreign_key "users", "year_levels"
end
