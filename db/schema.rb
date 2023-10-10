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

ActiveRecord::Schema[7.0].define(version: 2023_10_10_080143) do
  create_table "awards", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "game_id", null: false
    t.string "title", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "order_number", default: 1, null: false
    t.index ["game_id"], name: "index_awards_on_game_id"
  end

  create_table "card_logs", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "card_id", null: false
    t.string "action"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["card_id"], name: "index_card_logs_on_card_id"
  end

  create_table "cards", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "player_id", null: false
    t.bigint "game_id", null: false
    t.json "numbers"
    t.integer "bingo_lines", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_cards_on_game_id"
    t.index ["player_id"], name: "index_cards_on_player_id"
  end

  create_table "game_logs", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "game_id", null: false
    t.integer "emit_number", limit: 2, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_game_logs_on_game_id"
  end

  create_table "games", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "title"
    t.integer "max_winners", limit: 2, default: 1, null: false
    t.integer "max_players", limit: 3, default: 1, null: false
    t.integer "entry_period_minutes", limit: 2, default: 5, null: false
    t.datetime "started_at"
    t.datetime "finished_at"
    t.boolean "random_awards", default: false, null: false
    t.string "players_url_hash", null: false
    t.string "owners_url_hash", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0, null: false
    t.datetime "entry_close_at"
    t.integer "need_bingo_lines", limit: 2, default: 1, null: false
    t.index ["owners_url_hash"], name: "index_games_on_owners_url_hash", unique: true
    t.index ["players_url_hash"], name: "index_games_on_players_url_hash", unique: true
  end

  create_table "owners", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "game_id", null: false
    t.string "name", default: "", null: false
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_owners_on_game_id"
    t.index ["game_id"], name: "unique_index_on_game_id", unique: true
    t.index ["name"], name: "index_owners_on_name", unique: true
  end

  create_table "players", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "url_hash", default: "", null: false
    t.bigint "game_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_players_on_game_id"
    t.index ["url_hash"], name: "index_players_on_url_hash", unique: true
    t.index ["user_id"], name: "index_players_on_user_id"
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "email_address"
    t.string "hashed_password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email_address"], name: "index_users_on_email_address", unique: true
  end

  create_table "winners", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "game_id", null: false
    t.bigint "award_id"
    t.bigint "user_id", null: false
    t.text "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["award_id"], name: "index_winners_on_award_id"
    t.index ["game_id"], name: "index_winners_on_game_id"
    t.index ["user_id"], name: "index_winners_on_user_id"
  end

  add_foreign_key "awards", "games"
  add_foreign_key "card_logs", "cards"
  add_foreign_key "cards", "games"
  add_foreign_key "cards", "players"
  add_foreign_key "game_logs", "games"
  add_foreign_key "owners", "games"
  add_foreign_key "players", "games"
  add_foreign_key "players", "users"
  add_foreign_key "winners", "awards"
  add_foreign_key "winners", "games"
  add_foreign_key "winners", "users"
end
