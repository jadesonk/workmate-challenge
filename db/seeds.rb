puts "START SEED"

User.destroy_all
Job.destroy_all

puts "Create user name John"
User.create(name: "John")

puts "Create job titled Barista"
Job.create(title: "Barista")

puts "END SEED"
