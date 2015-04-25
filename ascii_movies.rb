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
	def initialize(movies)
		@movies = movies
	end

	def print(format)
		output = ""
		unless @movies == [""]
			output = define_ratings_grid
			output = output.map{|row| row.join}.join("|\n").concat("|\n")
		end	
		output
	end

	def get_highest_rating
		@movies.map{|movie| movie.rating}.max
	end

	def define_ratings_grid
		output =[]
		max_rating = get_highest_rating
		max_rating.times{|n| output << []}
		@movies.each_with_index do |movie, index|
			rating = movie.rating
			diff = max_rating - rating
			max_rating.times do |n|		
				if rating < max_rating && n < diff			
					output[n] << "| "		
				else
					output[n] << "|#"
				end
			end	
			output << ["| "] if max_rating == 0 && rating == 0
		end
		output
	end
end





