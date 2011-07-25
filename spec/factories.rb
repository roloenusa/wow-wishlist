# By using the syml ':user', we get Factory Girl to simulate the User model.
Factory.define :user do |user|
  user.name                  "Melanio Reyes"
  user.email                 "melanio@gmail.com"
  user.password              "foobar"
  user.password_confirmation "foobar"
end

Factory.sequence :email do |n|
  "person-#{n}@example.com"
end