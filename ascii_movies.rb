require 'pry'
require 'imdb'

class MovieGetter
	def initialize(movie, search_engine)
		@movie = movie
		@search_engine = search_engine
	end

	def get_movie
		if @movie == ""
			raise "No movies where given"
		elsif @search_engine.class == IMDBSearcher
			imdb_movie = @search_engine.search_movie(@movie)
			usable_movie = Movie.new(imdb_movie.title, imdb_movie.rating)
		elsif @search_engine.class != IMDBSearcher
			raise "The search engine is not valid. Please use IMDBSearcher"
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

class RatingPrinter
	def initialize(movie)
		@movie = movie
	end

	def print(format)
		if @movie == ""
			@movie
		elsif @movie.rating == 0
			"| |"
		else
			'|#|'
		end
	end
end





