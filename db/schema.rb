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

ActiveRecord::Schema.define(version: 2019_04_26_050810) do

  create_table "menu_roles", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "menu_id"
    t.bigint "role_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["menu_id"], name: "index_menu_roles_on_menu_id"
    t.index ["role_id"], name: "index_menu_roles_on_role_id"
  end

  create_table "menus", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", comment: "菜单名"
    t.string "controller_path", comment: "系统菜单路径"
    t.string "system_menu_name", comment: "系统菜单名"
    t.string "description", comment: "菜单简述"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pundit_group_roles", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "menu_id", comment: "菜单"
    t.bigint "role_id", comment: "角色"
    t.string "controller_path", comment: "控制器（菜单）路径，例：background/menus "
    t.string "group_name", comment: "权限组，例： create"
    t.string "action_list", comment: "权限列表，例：new,create"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["menu_id"], name: "index_pundit_group_roles_on_menu_id"
    t.index ["role_id"], name: "index_pundit_group_roles_on_role_id"
  end

  create_table "role_menus", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "role_id", comment: "角色id"
    t.bigint "menu_id", comment: "菜单id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["menu_id"], name: "index_role_menus_on_menu_id"
    t.index ["role_id"], name: "index_role_menus_on_role_id"
  end

  create_table "role_users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "role_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["role_id"], name: "index_role_users_on_role_id"
    t.index ["user_id"], name: "index_role_users_on_user_id"
  end

  create_table "roles", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", comment: "角色名"
    t.string "desc", comment: "描述"
    t.string "category_type", comment: "角色分类：采购人、管理员"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "login_name", comment: "登录名"
    t.string "real_name", comment: "真实姓名"
    t.string "password_digest", comment: "密码"
    t.integer "current_role_id", comment: "当前角色ID"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "menu_roles", "menus"
  add_foreign_key "menu_roles", "roles"
  add_foreign_key "pundit_group_roles", "menus"
  add_foreign_key "pundit_group_roles", "roles"
  add_foreign_key "role_menus", "menus"
  add_foreign_key "role_menus", "roles"
  add_foreign_key "role_users", "roles"
  add_foreign_key "role_users", "users"
end
