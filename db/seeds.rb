Category.create(name: "Покупка")
Category.create(name: "Продажа")
Category.create(name: "Аренда")
Category.create(name: "Работа")

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
admin.add_role(:admin)

20.times do |i|
  Advertisement.create(ad_title: "Куплю гараж №#{i+1}", ad_text: "Куплю гараж. Куплю гараж. Куплю гараж. Куплю гараж. Куплю гараж. Куплю гараж. Куплю гараж. Куплю гараж. Куплю гараж. Куплю гараж. ", category_id: 1, user: user1)
  Advertisement.create(ad_title: "Продам гараж №#{i+1}", ad_text: "Продам гараж. Продам гараж. Продам гараж. Продам гараж. Продам гараж. Продам гараж. Продам гараж. Продам гараж. Продам гараж. ", category_id: 2, user: user2)
  Advertisement.create(ad_title: "Арендую гараж №#{i+1}", ad_text: "Арендую гараж. Арендую гараж. Арендую гараж. Арендую гараж. Арендую гараж. Арендую гараж. Арендую гараж. Арендую гараж. Арендую гараж. ", category_id: 3, user: user3)
  Advertisement.create(ad_title: "Хочу работать в гараже №#{i+1}", ad_text: "Хочу работать в гараже. Хочу работать в гараже. Хочу работать в гараже. Хочу работать в гараже. Хочу работать в гараже. ", category_id: 4, user: user4)
end
