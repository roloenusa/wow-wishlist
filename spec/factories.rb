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

Factory.define :realm do |realm|
  realm.region      "us"
  realm.tipe        "pvp"
  realm.queue       false
  realm.status      true
  realm.population  "high"
  realm.name        "Sargeras"
  realm.slug        "sargeras"
end 

Factory.define :character do |character|
  character.lastmodified      1311477650000
  character.name              "Sodastereo"
  character.realm             "Sargeras"
  character.klass             11
  character.race              4
  character.gender            0
  character.level             85
  character.achievementpoints 6600
  character.thumbnail         "sargeras/189/860861-avatar.jpg"
  character.realm_id          1
end