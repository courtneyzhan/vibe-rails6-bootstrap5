# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_09_19_094014) do

  create_table "moods", force: :cascade do |t|
    t.string "mood"
    t.date "date"
    t.integer "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "posts", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.integer "user_id"
    t.string "post_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "posted_on"
    t.integer "question_id"
    t.index ["question_id"], name: "index_posts_on_question_id"
  end

  create_table "questions", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "login"
    t.string "email"
    t.string "first_name"
    t.string "last_name"
    t.string "mobile"
    t.string "gender"
    t.date "birth_date"
    t.string "auth_token"
    t.string "password_digest"
    t.string "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.string "avatar"
    t.string "locale"
    t.string "time_zone"
    t.string "remember_digest"
    t.string "activation_digest"
    t.boolean "activated", default: false
    t.datetime "activated_at"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email"
    t.index ["login"], name: "index_users_on_login"
  end

end
