require 'pry'
require 'imdb'

class MovieGetter
	def initialize(movie)
		@movie = movie
	end

	def get_movie
		if @movie == ""
			""
		else
			imdb_movie = IMDBSearcher.new.search_movie(@movie)
			my_movie = Movie.new(imdb_movie.title, imdb_movie.rating)
		end
	end
end

class Movie
	attr_reader :title, :rating
	def initialize(title, rating)
		@title = title
		@rating = rating
	end
end

class IMDBSearcher
	def search_movie(movie_title)
		search = Imdb::Search.new(movie_title)
		search.movies[0]
	end
end