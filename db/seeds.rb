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

Genre.create!(
  [
    {
      name: "和食"
    },
    {
      name: "洋食"
    },
    {
      name: "中華"
    }
  ]
)

recipe = Recipe.create!(user_id: 1,
                      genre_id: 2,
                      title: "昔ながらのケチャップオムライス",
                      catch_phrase: "喫茶店にあるような昔ながらのオムライスです！",
                      number_of_persons: "2人分",
                      tip: "フライパンが錆びていたりすると卵がくっつくため難しいです。
                            なるべく、テフロンが効いたフライパンを使いましょう。",
                      background: "喫茶店でよく食べたあの味を家で再現してみたかったので、作ってみました。
                                  結構シンプルが一番喫茶店の味に似ます！")
recipe.image.attach(io: File.open(Rails.root.join('app/assets/images/omurice.jpeg')),
                      filename: 'omurice.jpeg')


Ingredient.create(recipe_id: 1,
              name: "卵",
              quantity: "4個"
)

Ingredient.create(recipe_id: 1,
              name: "温かいご飯",
              quantity: "300g"
)

Ingredient.create(recipe_id: 1,
              name: "とりもも肉",
              quantity: "80g"
)

Ingredient.create(recipe_id: 1,
              name: "玉ねぎ",
              quantity: "1/4"
)

Ingredient.create(recipe_id: 1,
              name: "パセリのみじん切り",
              quantity: "少々"
)

Ingredient.create(recipe_id: 1,
              name: "牛乳",
              quantity: "大さじ２"
)

Ingredient.create(recipe_id: 1,
              name: "バター",
              quantity: "適量"
)

Ingredient.create(recipe_id: 1,
              name: "塩胡椒",
              quantity: "少々"
)

Ingredient.create(recipe_id: 1,
              name: "トマトケチャップ",
              quantity: "適量"
)

Ingredient.create(recipe_id: 1,
              name: "サラダ油",
              quantity: "少々"
)

Step.create(recipe_id: 1,
  step: 1,
  description: "チキンライスを作る。鶏肉は脂肪をとる。玉ねぎは1.5㎝四方に切る。"
)

Step.create(recipe_id: 1,
  step: 2,
  description: "バター大さじ1とかし、弱めの中火で熱し、他鶏肉と玉ねぎを炒める。 火が通ったらご飯をほぐしながら炒める。"
)

Step.create(recipe_id: 1,
  step: 3,
  description: "ご飯がぱらりとしたらケチャップを入れ、全体に馴染ませ、パセリを加え、お皿に移しておく。"
)

Step.create(recipe_id: 1,
  step: 4,
  description: "1人分ずつ作る。 ボールに卵2個入れ、牛乳大さじ1、塩少々入れしっかり溶きほぐす。"
)

Step.create(recipe_id: 1,
  step: 5,
  description: "フライパンにサラダ油小さじ2加え、1分ほど熱する。 卵液を一度に加え、手早く混ぜる。"
)

Step.create(recipe_id: 1,
  step: 6,
  description: "卵の中心が半熟状になったら、火を止める。 チキンライスの1/2を卵の中心よりやや手前に横長のラグビーボールのように乗せる。
                フライパンを手前に傾け、反対側の卵をかぶせる。"
)

Step.create(recipe_id: 1,
  step: 7,
  description: "卵がかぶさったら、フライ返しで手前に引き寄せてフライパンの側面に軽く押し当てながら形を作る。"
)

Step.create(recipe_id: 1,
  step: 8,
  description: "フライパンを少し傾け、お皿に縁が当たるぐらいまで傾ける。 チキンライスがこぼれないように合わせ目にふらい返しをあて、
                その上にオムライスをかぶせるようにして、そっとフライパンを返し、お皿にオムライスを乗せる。"
)

Tag.create(name: "卵"
)

Tag.create(name: "オムライス"
)

Tag.create(name: "喫茶店"
)

Tag.create(name: "トマト"
)

RecipeTag.create(recipe_id: 1,
                tag_id: 1
)

RecipeTag.create(recipe_id: 1,
                tag_id: 2
)

RecipeTag.create(recipe_id: 1,
                tag_id: 3
)

RecipeTag.create(recipe_id: 1,
                tag_id: 4
)

StockFood.create(user_id: 1,
                name: "大根",
                expiration_date: "2022/01/01"
)

StockFood.create(user_id: 1,
  name: "レタス",
  expiration_date: "2022/01/13"
)