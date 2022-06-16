# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.create!(
  email: 'admin@test.com',
  password: 'adminpass'
  )

User.create!(
  email: 'user@test.com',
  password: 'userpass',
  last_name: "田中",
  first_name: "太郎",
  last_name_kana: "タナカ",
  first_name_kana: "タロウ",
  nick_name: "タナ太郎",
  postal_code: "1111111",
  address: "東京都渋谷区代々木１−２−３",
  phone_number: "09011112222",
  birth_date: "2001-11-11",
  is_valid: "true"
)