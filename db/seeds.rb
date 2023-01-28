# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# ユーザの初期データ
user = User.create!(email: "geregere@example.com", password: "password", username: "geregere", handlename: "ゲレゲレ", introduction: "初心者です！おてやわらかに")
user.profile_image.attach(io: File.open(Rails.root.join("app/assets/images/Icon_images/illustrain01-tori03.png")), filename: 'icon.jpg')
user = User.create!(email: "kings@example.com", password: "password", username: "kings", handlename: "キングス", introduction: "中級者です！おてやわらかに")
user.profile_image.attach(io: File.open(Rails.root.join("app/assets/images/Icon_images/illustrain02-dog23.png")), filename: 'icon.jpg')
user = User.create!(email: "smith@example.com", password: "password", username: "smith", handlename: "スミス", introduction: "上級者です！おてやわらかに")
user.profile_image.attach(io: File.open(Rails.root.join("app/assets/images/Icon_images/illustrain06-dobutu24.png")), filename: 'icon.jpg')
user = User.create!(email: "gorems@example.com", password: "password", username: "gorems", handlename: "ゴレムス", introduction: "初心者です！たすけてください！！！")
user.profile_image.attach(io: File.open(Rails.root.join("app/assets/images/Icon_images/illustrain06-saru01.png")), filename: 'icon.jpg')
user = User.create!(email: "pierre@example.com", password: "password", username: "pierre", handlename: "ピエール", introduction: "中級者です！なんでも聞いてね")
user.profile_image.attach(io: File.open(Rails.root.join("app/assets/images/Icon_images/illustrain09-doubutu10.png")), filename: 'icon.jpg')
user = User.create!(email: "hagrinre@example.com", password: "password", username: "hagrin", handlename: "はぐりん", introduction: "上級者です！イラストのお題募集してます")
user.profile_image.attach(io: File.open(Rails.root.join("app/assets/images/Icon_images/illustrain09-kyouryu8.png")), filename: 'icon.jpg')
user = User.create!(email: "kadabu@example.com", password: "password", username: "kadabu", handlename: "カダブウ", introduction: "プロです！お仕事受け付けてます")
user.profile_image.attach(io: File.open(Rails.root.join("app/assets/images/Icon_images/illustrain09-neko3.png")), filename: 'icon.jpg')

# 投稿の初期データ
post = Post.create!(user_id: 7, title: "魔導少女", introduction: "某魔導兵器に乗る少女です!")
illust = Illust.create!(post_id: post.id, step: "draft")
illust.illust_image.attach(io: File.open(Rails.root.join("app/assets/images/Illust_images/tina_01.jpg")), filename: 'tina01.jpg')
illust = Illust.create!(post_id: post.id, step: "linedraw")
illust.illust_image.attach(io: File.open(Rails.root.join("app/assets/images/Illust_images/tina_02.jpg")), filename: 'tina02.jpg')
illust = Illust.create!(post_id: post.id, step: "color")
illust.illust_image.attach(io: File.open(Rails.root.join("app/assets/images/Illust_images/tina_03.jpg")), filename: 'tina03.jpg')
illust = Illust.create!(post_id: post.id, step: "finish")
illust.illust_image.attach(io: File.open(Rails.root.join("app/assets/images/Illust_images/tina_04.jpg")), filename: 'tina04.jpg')
tag = Tag.create!(name: "魔導少女")
PostTag.create!(post_id: post.id, tag_id: tag.id)
tag = Tag.create!(name: "ファンタジー")
PostTag.create!(post_id: post.id, tag_id: tag.id)
tag = Tag.create!(name: "魔導")
PostTag.create!(post_id: post.id, tag_id: tag.id)
tag = Tag.create!(name: "少女")
PostTag.create!(post_id: post.id, tag_id: tag.id)

post = Post.create!(user_id: 7, title: "一国の姫", introduction: "某攫われがちなヒロインです！")
illust = Illust.create!(post_id: post.id, step: "draft")
illust.illust_image.attach(io: File.open(Rails.root.join("app/assets/images/Illust_images/zelda01.jpg")), filename: 'zelda01.jpg')
illust = Illust.create!(post_id: post.id, step: "linedraw")
illust.illust_image.attach(io: File.open(Rails.root.join("app/assets/images/Illust_images/zelda02.jpg")), filename: 'zelda02.jpg')
illust = Illust.create!(post_id: post.id, step: "color")
illust.illust_image.attach(io: File.open(Rails.root.join("app/assets/images/Illust_images/zelda03.jpg")), filename: 'zelda03.jpg')
illust = Illust.create!(post_id: post.id, step: "finish")
illust.illust_image.attach(io: File.open(Rails.root.join("app/assets/images/Illust_images/zelda04.jpg")), filename: 'zelda04.jpg')
tag = Tag.create!(name: "姫chan")
PostTag.create!(post_id: post.id, tag_id: tag.id)
tag = Tag.create!(name: "某大乱闘ゲームで魔王を処しがち")
PostTag.create!(post_id: post.id, tag_id: tag.id)
tag = Tag.create!(name: "最新作楽しみ")
PostTag.create!(post_id: post.id, tag_id: tag.id)

post = Post.create!(user_id: 7, title: "遺伝子組み換え女子", introduction: "いつもはもっとゴツいスーツ着てます！")
illust = Illust.create!(post_id: post.id, step: "draft")
illust.illust_image.attach(io: File.open(Rails.root.join("app/assets/images/Illust_images/samus01.jpg")), filename: 'samus01.jpg')
illust = Illust.create!(post_id: post.id, step: "linedraw")
illust.illust_image.attach(io: File.open(Rails.root.join("app/assets/images/Illust_images/samus02.jpg")), filename: 'samus02.jpg')
illust = Illust.create!(post_id: post.id, step: "color")
illust.illust_image.attach(io: File.open(Rails.root.join("app/assets/images/Illust_images/samus03.jpg")), filename: 'samus03.jpg')
illust = Illust.create!(post_id: post.id, step: "finish")
illust.illust_image.attach(io: File.open(Rails.root.join("app/assets/images/Illust_images/samus04.jpg")), filename: 'samus04.jpg')
tag = Tag.create!(name: "バウンティハンター")
PostTag.create!(post_id: post.id, tag_id: tag.id)
tag = Tag.create!(name: "丸くなれます")
PostTag.create!(post_id: post.id, tag_id: tag.id)
tag = Tag.create!(name: "スーツ脱いだ方が強い")
PostTag.create!(post_id: post.id, tag_id: tag.id)

post = Post.create!(user_id: 7, title: "例の幼馴染組", introduction: "こっちのCPを推します")
illust = Illust.create!(post_id: post.id, step: "draft")
illust.illust_image.attach(io: File.open(Rails.root.join("app/assets/images/Illust_images/two01.jpg")), filename: 'two01.jpg')
illust = Illust.create!(post_id: post.id, step: "linedraw")
illust.illust_image.attach(io: File.open(Rails.root.join("app/assets/images/Illust_images/two02.jpg")), filename: 'two02.jpg')
illust = Illust.create!(post_id: post.id, step: "color")
illust.illust_image.attach(io: File.open(Rails.root.join("app/assets/images/Illust_images/two03.jpg")), filename: 'two03.jpg')
illust = Illust.create!(post_id: post.id, step: "finish")
illust.illust_image.attach(io: File.open(Rails.root.join("app/assets/images/Illust_images/two04.jpg")), filename: 'two04.jpg')
tag = Tag.create!(name: "ストーカー被害者")
PostTag.create!(post_id: post.id, tag_id: tag.id)
tag = Tag.create!(name: "続編はよ")
PostTag.create!(post_id: post.id, tag_id: tag.id)
tag = Tag.create!(name: "天の川")
PostTag.create!(post_id: post.id, tag_id: tag.id)

post = Post.create!(user_id: 4, title: "りんご", introduction: "5分で描きました")
illust = Illust.create!(post_id: post.id, step: "draft")
illust.illust_image.attach(io: File.open(Rails.root.join("app/assets/images/Illust_images/apple01.jpg")), filename: 'apple01.jpg')
illust = Illust.create!(post_id: post.id, step: "linedraw")
illust.illust_image.attach(io: File.open(Rails.root.join("app/assets/images/Illust_images/apple02.jpg")), filename: 'apple02.jpg')
illust = Illust.create!(post_id: post.id, step: "color")
illust.illust_image.attach(io: File.open(Rails.root.join("app/assets/images/Illust_images/apple03.jpg")), filename: 'apple03.jpg')
illust = Illust.create!(post_id: post.id, step: "finish")
illust.illust_image.attach(io: File.open(Rails.root.join("app/assets/images/Illust_images/apple04.jpg")), filename: 'apple04.jpg')
tag = Tag.create!(name: "りんご")
PostTag.create!(post_id: post.id, tag_id: tag.id)
tag = Tag.create!(name: "赤")
PostTag.create!(post_id: post.id, tag_id: tag.id)
tag = Tag.create!(name: "初投稿")
PostTag.create!(post_id: post.id, tag_id: tag.id)


Admin.create!(
 email: 'admin@admin.com',
 password: 'password'
)