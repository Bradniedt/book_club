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
BookAuthor.destroy_all


tolkein = Author.create(name: "John Ronald Reuel Tolkien")
book_1 = tolkein.books.create(title: "The Hobbit", pages: 310, year: 1937 )
book_2 = tolkein.books.create(title: "The Fellowship of the Ring", pages: 423, year: 1954 )
book_3 = tolkein.books.create(title: "The Two Towers", pages: 352, year: 1937 )
book_4 = tolkein.books.create(title: "The Return of the King", pages: 416, year: 1954 )

sanderson = Author.create(name: "Brandon Sanderson")
book_5 = sanderson.books.create(title: "The Way of Kings", pages: 1057, year: 2009 )
book_6 = sanderson.books.create(title: "Oathbringer", pages: 1200, year: 2012 )
book_7 = sanderson.books.create(title: "Words of Radiance", pages: 1057, year: 2013 )
jordan = Author.create(name: "Rober Jordan ")
book_8 = Book.create(title: "Towes of Midnight", pages: 1057, year: 2009, authors: [jordan, sanderson])

user_1 = User.create(name: "Han Solo")
user_2 = User.create(name: "Leia Skywalker")
user_3 = User.create(name: "Luke Skywalker")
user_4 = User.create(name: "Frodo Beggins")
user_5 = User.create(name: "Samewise Gamgee")

review_1 = user_1.reviews.create(title: "Great Story" , description:"I loved the elves!", rating: 5, book: book_1, user: user_1)
review_2 = user_2.reviews.create(title: "Sub-par" , description:"I thought that bilbo should've stayed home.", rating: 1, book: book_1, user: user_2)
review_3 = user_3.reviews.create(title: "Too Good" , description:"Nothing IRL can be as good as this story, nihlism.", rating: 1, book: book_1, user: user_3)


review_4 = user_1.reviews.create(title: "Top-notch" , description:"It was a great struggle - can't wait to find out what happens next!", rating: 5, book: book_2, user: user_1)
review_5 = user_2.reviews.create(title: "Underwhelmed" , description:"Where have all of the good times gone? Middle earth is lost.", rating: 3, book: book_2, user: user_2)


review_6 = user_1.reviews.create(title: "BS" , description:"Aragorn's dad should've destroyed the ring when he had the chance. This is BS.", rating: 3, book: book_3, user: user_1)
review_7 = user_2.reviews.create(title: "Gollum Love" , description:"I don't like that Sam keeps hating on Gollum every chance he gets. WTF", rating: 3, book: book_3, user: user_2)


review_8 = user_1.reviews.create(title: "Mindblowing" , description:"Brandon Sanderson amazing as always", rating: 5, book: book_5, user: user_1)
review_9 = user_3.reviews.create(title: "Bad book" , description:"To complex and consistent for me", rating: 1, book: book_5, user: user_3)


review_10 = user_1.reviews.create(title: "Questioning Sanderson" , description:"Did not appreciate the addition of Brandon in this book", rating: 2, book: book_8, user: user_1)
review_11 = user_3.reviews.create(title: "Meh" , description:"Why is this guy acting like this?", rating: 3, book: book_8, user: user_3)
review_12 = user_5.reviews.create(title: "Love it!" , description:"So engaging, could not stop reading", rating: 5, book: book_8, user: user_5)
