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

ActiveRecord::Schema.define(version: 2018_09_16_214721) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", force: :cascade do |t|
    t.text "content", null: false
    t.boolean "correct", default: false, null: false
    t.bigint "team_exercise_id"
    t.bigint "question_id"
    t.bigint "user_id"
    t.bigint "programming_language_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["programming_language_id"], name: "index_answers_on_programming_language_id"
    t.index ["question_id"], name: "index_answers_on_question_id"
    t.index ["team_exercise_id"], name: "index_answers_on_team_exercise_id"
    t.index ["user_id"], name: "index_answers_on_user_id"
  end

  create_table "exercise_questions", force: :cascade do |t|
    t.bigint "question_id"
    t.bigint "exercise_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["exercise_id"], name: "index_exercise_questions_on_exercise_id"
    t.index ["question_id", "exercise_id"], name: "index_exercise_questions_on_question_id_and_exercise_id", unique: true
    t.index ["question_id"], name: "index_exercise_questions_on_question_id"
  end

  create_table "exercises", force: :cascade do |t|
    t.string "title", null: false
    t.text "description"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_exercises_on_user_id"
  end

  create_table "programming_languages", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_programming_languages_on_name"
  end

  create_table "questions", force: :cascade do |t|
    t.string "title", null: false
    t.text "description", null: false
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_questions_on_user_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.bigint "resource_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource_type_and_resource_id"
  end

  create_table "team_exercise_programming_languages", force: :cascade do |t|
    t.bigint "team_exercise_id"
    t.bigint "programming_language_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["programming_language_id"], name: "index_tepl_on_programming_language_id"
    t.index ["team_exercise_id", "programming_language_id"], name: "index_tepl_on_team_exercise_id_and_programming_language_id", unique: true
    t.index ["team_exercise_id"], name: "index_tepl_on_team_exercise_id"
  end

  create_table "team_exercises", force: :cascade do |t|
    t.boolean "active", default: false, null: false
    t.bigint "team_id"
    t.bigint "exercise_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["exercise_id"], name: "index_team_exercises_on_exercise_id"
    t.index ["team_id", "exercise_id"], name: "index_team_exercises_on_team_id_and_exercise_id", unique: true
    t.index ["team_id"], name: "index_team_exercises_on_team_id"
  end

  create_table "team_users", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "team_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_id"], name: "index_team_users_on_team_id"
    t.index ["user_id", "team_id"], name: "index_team_users_on_user_id_and_team_id", unique: true
    t.index ["user_id"], name: "index_team_users_on_user_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.boolean "active", default: true, null: false
    t.string "password", null: false
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_teams_on_user_id"
  end

  create_table "test_cases", force: :cascade do |t|
    t.text "input"
    t.text "output", null: false
    t.bigint "question_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_test_cases_on_question_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "last_name", null: false
    t.string "email", null: false
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email"
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "role_id"
    t.index ["role_id"], name: "index_users_roles_on_role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
    t.index ["user_id"], name: "index_users_roles_on_user_id"
  end

  add_foreign_key "answers", "programming_languages"
  add_foreign_key "answers", "questions"
  add_foreign_key "answers", "team_exercises"
  add_foreign_key "answers", "users"
  add_foreign_key "exercise_questions", "exercises"
  add_foreign_key "exercise_questions", "questions"
  add_foreign_key "exercises", "users"
  add_foreign_key "questions", "users"
  add_foreign_key "team_exercise_programming_languages", "programming_languages"
  add_foreign_key "team_exercise_programming_languages", "team_exercises"
  add_foreign_key "team_exercises", "exercises"
  add_foreign_key "team_exercises", "teams"
  add_foreign_key "team_users", "teams"
  add_foreign_key "team_users", "users"
  add_foreign_key "teams", "users"
  add_foreign_key "test_cases", "questions"
end
