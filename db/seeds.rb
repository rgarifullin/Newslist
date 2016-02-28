# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
news1 = News.create(
  author: 'Fox',
  text: 'Britain scientists developed new amazing technology.'
)
news2 = News.create(
  author: 'Smith',
  text: 'New film about agent 007 was released.'
)

admin = User.create(
  email: 'admin@newslist.com',
  password: 'nicepasswd',
  role: 1
)
viewer = User.create(
  email: 'viewer@newslist.com',
  password: 'badpasswd',
  role: 0
)

Newsuser.create(user_id: admin.id, news_id: news1.id, read: true)
Newsuser.create(user_id: admin.id, news_id: news2.id)
Newsuser.create(user_id: viewer.id, news_id: news1.id)
Newsuser.create(user_id: viewer.id, news_id: news2.id, read: true)
