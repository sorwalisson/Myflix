Hello Everyone, this is an API design to mimic in a smaller scale the netflix platform with the purpose to improve my portfolio.

Ruby version: 3.1.2
Rails version: 7.0.4

I used rspec and factory bot to build up tests, and for serializer i used AMS.

Feedbacks are welcome, and Thank you for spending a little bit of your time in order to help me out.

So the Controllers are in the API::V1 folders

Users has an 'active" attribute to check his subscriptions, and the payment methods is start_payment that should be called on user, nothing fancy, just for 'academic purpose'.

The user can add a title to his favorites by using the route api/v1/titles/:titles_id/favorite(POST / DELETE) the same url does both actions just depends on the request.

to summarize.

Title (movies/shows/documentaries)
Content(belongs to Title, if it is a movie the url will be displayed on the content, if it is a show the url will be in a futher model called episodes)
Season(which belongs to contents, and its used when the title is not a movie)
Episode(that belongs to the season, where the urls is stored when the title is not a movie)
Review(belongs to title, plain and simple as it should be)


and again, Thank you for speding a bit of your time!!!.

Cheers Walisson Santos
