# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'benchmark'
puts Benchmark.measure {
  500.times do
    Tarefa.create(
      titulo: Faker::Name.first_name,
      descricao: Faker::Name.last_name,
      status: Faker::Internet.email
    )
  end
}
