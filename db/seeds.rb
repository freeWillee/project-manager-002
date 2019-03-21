# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

users = User.create(
  [
    { username: 'admin', email: 'admin@mail.com', password: 'password', admin: 1},
    { username: 'Mason', email: 'mason@mail.com', password: 'password'},
    { username: 'Chloe', email: 'chloe@mail.com', password: 'password'},
    { username: 'Seb', email: 'seb@mail.com', password: 'password'},
    { username: 'Michael', email: 'michael@mail.com', password: 'password'},
    { username: 'Gus', email: 'gus@mail.com', password: 'password'},
    { username: 'Theo', email: 'theo@mail.com', password: 'password'},
  ]
  )

Project.create(
  [
    {name: 'Build-a-Bear', deadline: Date.new(2020, 12, 4)},
    {name: 'Treehouse', deadline: Date.new(2019, 5, 4)},
    {name: 'Fly-A-Kite', deadline: Date.new(2019, 6, 4)},
    {name: 'Theo Birthday', deadline: Date.new(2019, 7, 3)}
  ]
)

Task.create( 
  [
    { title: 'Gather Intel', content: "A horse jumped over the sheep today and a penguin said meow.", percent_complete: 30, user_id: 1, project_id: 1},
    { title: 'Take dog for a walk', content: "Blah blah tomorrow", percent_complete: 10, user_id: 2, project_id: 2},
    { title: 'Take pony for a walk', content: "booster seats.", percent_complete: 3, user_id: 3, project_id: 3},
    { title: 'Brush teeth', content: "yada yada yada.", percent_complete: 90, user_id: 4, project_id: 4},
    { title: 'Take out trash', content: "Lamps are fun to play with.", percent_complete: 40, user_id: 5, project_id: 2},
    { title: 'Type a letter', content: "Lamps are fun to play with.", percent_complete: 30, user_id: 6, project_id: 5},
    { title: 'Pay the bill', content: "Lamps are fun to play with.", percent_complete: 20, user_id: 7, project_id: 5},
    { title: 'Get tires repaired', content: "Lamps are fun to play with.", percent_complete: 64, user_id: 1, project_id: 1},
    { title: 'Paint the walls', content: "Lamps are fun to play with.", percent_complete: 10, user_id: 4, project_id: 3},
    { title: 'Watch the movie', content: "Lamps are fun to play with.", percent_complete: 10, user_id: 3, project_id: 3},
    { title: 'Sing a Song', content: "Lamps are fun to play with.", percent_complete: 10, user_id: 6, project_id: 2},
    { title: 'Rehearse', content: "Lamps are fun to play with.", percent_complete: 10, user_id: 7, project_id: 1},
    { title: 'Jumping Jacks', content: "Lamps are fun to play with.", percent_complete: 10, user_id: 4, project_id: 4},
    { title: 'Buy shoes', content: "Lamps are fun to play with.", percent_complete: 10, user_id: 2, project_id: 4},
    { title: 'Nap for 3 hrs', content: "Lamps are fun to play with.", percent_complete: 10, user_id: 1, project_id: 5},
    { title: 'Write a poem', content: "Lamps are fun to play with.", percent_complete: 10, user_id: 2, project_id: 5},
    { title: 'Advertise', content: "Lamps are fun to play with.", percent_complete: 10, user_id: 6, project_id: 4},
    { title: 'Email responses', content: "Lamps are fun to play with.", percent_complete: 10, user_id: 6, project_id: 3},
    { title: 'Tour the site', content: "Lamps are fun to play with.", percent_complete: 10, user_id: 7, project_id: 1},
    { title: 'Walk in the park', content: "Lamps are fun to play with.", percent_complete: 10, user_id: 4, project_id: 3}
  ]
)