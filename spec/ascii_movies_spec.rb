require_relative('../ascii_movies')

RSpec.describe "Ascii Movies" do
	let(:ghostbusters) do
		instance_double("Movie",
			:title => "Los Cazafantasmas (1984)",
			:rating => 7.8)
	end

	it "MovieGetter raises error when no film is passed" do
		movie_getter = MovieGetter.new("", IMDBSearcher.new)
		expect{movie_getter.get_movie}.to raise_error "No movies where given"
	end
	it "MovieGetter returns the instance of a movie when a title passed" do
		movie_getter = MovieGetter.new("Ghostbusters", IMDBSearcher.new)
		expect(movie_getter.get_movie.title).to eq(ghostbusters.title)
	end

	it "MovieGetter raises error when not using IMDBSearcher" do
		filmaffinity_searcher = "an awesome movie searcher"
		movie_getter = MovieGetter.new("Ghostbusters", filmaffinity_searcher)
		expect{movie_getter.get_movie}.to raise_error "The search engine is not valid. Please use IMDBSearcher"
	end

	it "RatingPrinter paints nothing when an empty array is passed" do
		printer = RatingPrinter.new([])
		format = "ascii"
		expect(printer.print(format)).to eq("")
	end
end


# ascii_movies = AsciiMovies.new(MovieGetter.new, RatingPrinter.new)
