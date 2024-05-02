require "faker"

# Supprimer les données existantes
User.destroy_all
GossipTag.destroy_all
Gossip.destroy_all
Tag.destroy_all


# Créer 10 villes aléatoires
cities = []
10.times do
  city = City.create!(name: Faker::Address.city, zip_code: Faker::Address.postcode)
  cities << city
end

# Création d'utilisateurs factices
10.times do
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  email = Faker::Internet.email
  age = Faker::Number.between(from: 18, to: 90)
  city_id = Faker::Number.between(from: 1, to: 10)
  username = "#{first_name.downcase}.#{last_name.downcase}" # Utiliser une combinaison de prénom et de nom pour l'username

  # Vérifier si le nom d'utilisateur est unique, sinon en générer un nouveau
  while User.exists?(username: username)
    username = "#{username}.#{Faker::Number.unique.number(digits: 2)}" # Ajouter un nombre unique pour garantir l'unicité
  end

  User.create!(
    first_name: first_name,
    last_name: last_name,
    email: email,
    age: age,
    city_id: city_id,
    username: username,
    password: 'password123',
    password_confirmation: 'password123'
  )
end



# Créer 10 tags aléatoires
10.times do
  Tag.create!(name: Faker::Lorem.word)
end

# Créer 20 gossips aléatoires
20.times do
  user = User.all.sample
  gossip = user.gossips.create!(
    title: Faker::Hacker.say_something_smart,
    description: Faker::Lorem.paragraph(sentence_count: 5)
  )
  
  # Associer des tags aléatoires à chaque gossip
  rand(1..5).times do
    tag = Tag.all.sample
    gossip.tags << tag unless gossip.tags.include?(tag)
  end
end
