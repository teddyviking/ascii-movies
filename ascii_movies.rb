require 'pry'
require 'imdb'

class AsciiMovies
	def write_ratings(input, output)
		titles = InputConversor.new(input).extract_lines
		movies = titles.map do |title| 
			movie_getter = MovieGetter.new(title, IMDBSearcher.new)
			movie_getter.get_movie
		end
		text = RatingPrinter.new(movies).print("ascii") +"\n" + TitlePrinter.new(movies).print("ascii") 
		IO.write(output, text)
	end
end


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
		@rating = rating.to_i
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
			output = output.map{|row| row.join}.join("|\n").concat(stablish_ending)
		end	
		output
	end


	def define_ratings_grid
		max_rating = get_highest_rating
		output = define_output_structure(max_rating)
		populate_output(output, max_rating)
	end

	def get_highest_rating
		@movies.map{|movie| movie.rating}.max
	end

	def define_output_structure(max_rating)
		output = []
		max_rating.times{|n| output << []}
		output
	end

	def populate_output(output, max_rating)
		@movies.each do |movie|
			rating = movie.rating
			diff = max_rating - rating
			max_rating.times {|n| rating < max_rating && n < diff ? output[n] << "| " : output[n] << "|#"}
			output << ["| "] if max_rating == 0 && rating == 0
		end
		output
	end

	def stablish_ending
		basic_ending = "|\n-"
		@movies.each { |movie| basic_ending << "--" }
		basic_ending << "\n"
		@movies.each_with_index {|movie, i| basic_ending << "|#{i+1}" }
		basic_ending << "|\n"
		basic_ending
	end
end

class TitlePrinter
	def initialize(movies)
		@movies = movies
	end
	def print(format)
		output = ""
		unless @movies == [""]
			titles = @movies.map {|movie| movie.title}
			titles.each_with_index{|title, index| output << "#{index + 1}. #{title}\n"}
		end
		output
	end

end

class InputConversor
	def initialize(input)
		@input = input
	end

	def extract_lines
		IO.readlines(@input).map{|line|line.gsub(/\n/, "")}
	end
end




