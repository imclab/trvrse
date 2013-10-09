# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Location.create([
                  {name: "Honolulu, HI", lat: "21.306944", long: "-157.858333"},
                  {name: "San Francisco, CA", lat: "37.774929", long: "-122.419415"},
                  {name: "New York, NY", lat: "40.714269", long: "-74.005973"},
                  {name: "Hong Kong, Hong Kong", lat: "22.284014", long: "114.150074"},
                  {name: "Paris, France", lat: "48.866667", long: "2.333333"},
                  {name: "London, United Kingdom", lat: "51.5", long: "-0.116667"}
                ])