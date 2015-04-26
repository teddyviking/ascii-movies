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
	
	format = "ascii"

	let(:fake_movie) do
		instance_double("Movie",
			:title => "",
			:rating => 0)
	end
	let(:fake_movie_1) do
		instance_double("Movie",
			:title => "",
			:rating => 1)
	end
	let(:fake_movie_2) do
		instance_double("Movie",
			:title => "",
			:rating => 2)
	end

	it "RatingPrinter paints nothing when no movie is passed" do
		printer = RatingPrinter.new([""])
		expect(printer.print(format)).to eq("")
	end

	it "RatingPrinter paints an empty column when passed a movie with a puntuation of 0" do
		printer = RatingPrinter.new([fake_movie])
		expect(printer.print(format)).to eq("| |\n---\n|1|\n")
	end
	it "RatingPrinter paints a column with one # when passed a movie with a puntuation of 1" do
		printer = RatingPrinter.new([fake_movie_1])
		expect(printer.print(format)).to eq("|#|\n---\n|1|\n")
	end
	it "RatingPrinter paints a column with two # when passed a movie with a puntuation of 2" do
		printer = RatingPrinter.new([fake_movie_2])
		expect(printer.print(format)).to eq("|#|\n|#|\n---\n|1|\n")
	end
	it "RatingPrinter paints two columns when passed two movies" do
		printer = RatingPrinter.new([fake_movie_2, fake_movie_1])
		expect(printer.print(format)).to eq("|#| |\n|#|#|\n-----\n|1|2|\n")
	end


	it "TitlePrinter paints nothing when no movie is passed" do
		printer = TitlePrinter.new([""])
		expect(printer.print(format)).to eq("")
	end
end




# ascii_movies = AsciiMovies.new(MovieGetter.new, RatingPrinter.new)
