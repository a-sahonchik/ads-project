# frozen_string_literal: true

Category.create(name: 'Покупка')
Category.create(name: 'Продажа')
Category.create(name: 'Аренда')
Category.create(name: 'Работа')

Role.create(name: :admin)
Role.create(name: :user)

user1 = User.create(username: 'User1',
                    email: 'user1@test.com',
                    password: 'test1234',
                    password_confirmation: 'test1234')
user1.add_role(:user)

user2 = User.create(username: 'User2',
                    email: 'user2@test.com',
                    password: 'test1234',
                    password_confirmation: 'test1234')
user2.add_role(:user)

user3 = User.create(username: 'User3',
                    email: 'user3@test.com',
                    password: 'test1234',
                    password_confirmation: 'test1234')
user3.add_role(:user)

user4 = User.create(username: 'User4',
                    email: 'user4@test.com',
                    password: 'test1234',
                    password_confirmation: 'test1234')
user4.add_role(:user)

admin = User.create(username: 'Admin',
                    email: 'admin@test.com',
                    password: 'test1234',
                    password_confirmation: 'test1234')
admin.remove_role(:user)
admin.add_role(:admin)

20.times do |i|
  Advertisement.create(ad_title: "Куплю гараж №#{i + 1}",
                       ad_text: Faker::Lorem.paragraph(sentence_count: 10),
                       category_id: 1,
                       user: user1)
  Advertisement.create(ad_title: "Продам гараж №#{i + 1}",
                       ad_text: Faker::Lorem.paragraph(sentence_count: 10),
                       category_id: 2,
                       user: user2)
  Advertisement.create(ad_title: "Арендую гараж №#{i + 1}",
                       ad_text: Faker::Lorem.paragraph(sentence_count: 10),
                       category_id: 3,
                       user: user3)
  Advertisement.create(ad_title: "Хочу работать в гараже №#{i + 1}",
                       ad_text: Faker::Lorem.paragraph(sentence_count: 10),
                       category_id: 4,
                       user: user4)
end

50.times do |i|
  a = Advertisement.find((i + 1).to_s)
  a.state = 'published'
  a.save
end

5.times do |i|
  a = Advertisement.find((i + 51).to_s)
  a.state = 'opened'
  a.save
end

Advertisement.create(ad_title: "В названии нет слова на букву Г",
                       ad_text: 'В тексте слово ГАРАЖ упоминается только один раз. В названии это слово не упоминается. Поэтому это объявление будет не очень высоко в поиске.',
                       category_id: 1,
                       user: user1,
                       state: 'published')

Advertisement.create(ad_title: "В названии есть слово ГАРАЖ",
                       ad_text: 'В тексте слово ГАРАЖ упоминается один раз, в названии это слово упоминается один раз. Поэтому это объявление будет выше в поиске.',
                       category_id: 1,
                       user: user1,
                       state: 'published')

Advertisement.create(ad_title: "ГАРАЖ ГАРАЖ ГАРАЖ УХ КАК Я ЛЮБЛЮ СВОЙ ГАРАЖ",
                       ad_text: 'ЭТОТ ТЕКСТ ПРО ГАРАЖ, И НАЗВАНИЕ ЭТОГО ОБЪЯВЛЕНИЯ ТОЖЕ ПРО ГАРАЖ, ЭТО ТОП 1 В ПОИСКЕ ПО СЛОВУ ГАРАЖ. ГАРАЖ ГАРАЖ ГАРАЖ ГАРАЖ УХ КАКОЙ ГАРАЖ.',
                       category_id: 1,
                       user: user1,
                       state: 'published')
