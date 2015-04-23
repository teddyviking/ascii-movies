require_relative('../ascii_movies')

RSpec.describe "Ascii Movies" do
	let(:ghostbusters) do
		instance_double("Movie",
			:title => "Los Cazafantasmas (1984)",
			:rating => 7.8)
	end

	it "MovieGetter returns an empty string when no film is passed" do
		movie_getter = MovieGetter.new("")
		expect(movie_getter.get_movie).to eq("")
	end
	it "MovieGetter returns the instance of a movie when a title passed" do
		movie_getter = MovieGetter.new("Ghostbusters")
		expect(movie_getter.get_movie.title).to eq(ghostbusters.title)
	end

end


# ascii_movies = AsciiMovies.new(MovieGetter.new, RatingPrinter.new)
