# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Book.destroy_all
Review.destroy_all
Author.destroy_all
User.destroy_all


tolkein = Author.create(name: "John Ronald Reuel Tolkien")
book_1 = tolkein.books.create(title: "The Hobbit", pages: 310, year: 1937 )
book_2 = tolkein.books.create(title: "The Fellowship of the Ring", pages: 423, year: 1954 )
book_3 = tolkein.books.create(title: "The Two Towers", pages: 352, year: 1937 )
book_4 = tolkein.books.create(title: "The Return of the King", pages: 416, year: 1954 )
user_1 = User.create(name: "Han Solo")
user_2 = User.create(name: "Leia Skywalker")
user_3 = User.create(name: "Luke Skywalker")

review_1 = user_1.reviews.create!(title: "Great Story" , description:"I loved the elves!", rating: 5)
review_2 = user_2.reviews.create!(title: "Sub-par" , description:"I thought that bilbo should've stayed home.", rating: 1)
review_3 = user_3.reviews.create!(title: "Too Good" , description:"Nothing IRL can be as good as this story, nihlism.", rating: 1)
book_1.reviews << [review_1, review_2, review_3]

review_4 = user_1.reviews.create!(title: "Top-notch" , description:"It was a great struggle - can't wait to find out what happens next!", rating: 5)
review_5 = user_2.reviews.create!(title: "Underwhelmed" , description:"Where have all of the good times gone? Middle earth is lost.", rating: 3)
book_2.reviews << [review_4, review_5]

review_6 = user_1.reviews.create!(title: "BS" , description:"Aragorn's dad should've destroyed the ring when he had the chance. This is BS.", rating: 3)
review_7 = user_2.reviews.create!(title: "Gollum Love" , description:"I don't like that Sam keeps hating on Gollum every chance he gets. WTF", rating: 3)
book_3.reviews << [review_6, review_7]

review_8 = user_1.reviews.create!(title: "Good ending" , description:"So happy that the good guys win. FU great eye.", rating: 4)
review_9 = user_3.reviews.create!(title: "Am I missing something?" , description:"This could've ended before it all started", rating: 1)
book_4.reviews << [review_8, review_9]
