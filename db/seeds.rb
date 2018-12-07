# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Book.destroy_all
Review.destroy_all

book_1 = Book.create!(title: "book_1", pages: 100, year: 2000)
book_2 = Book.create!(title: "book_2", pages: 200, year: 2001)
book_3 = Book.create!(title: "book_3", pages: 240, year: 2004)
review_1 = book_1.reviews.create!(title: "good book" , description:"amazing", rating: 5)
review_2 = book_1.reviews.create!(title: "bad book" , description:"lame", rating: 1)
review_2 = book_1.reviews.create!(title: "really bad book" , description:"lame AF", rating: 1)
review_3 = book_2.reviews.create!(title: "good book" , description:"amazing", rating: 5)
review_4 = book_2.reviews.create!(title: "not great" , description:"blah", rating: 3)
review_4 = book_2.reviews.create!(title: "not good" , description:"meh", rating: 3)
review_4 = book_2.reviews.create!(title: "not the best" , description:"okay", rating: 3)
review_5 = book_3.reviews.create!(title: "good book" , description:"amazing", rating: 4)
review_6 = book_3.reviews.create!(title: "not great" , description:"blah", rating: 1)
