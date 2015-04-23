require_relative('../ascii_movies')

RSpec.describe "Ascii Movies" do
	it "MovieGetter returns an empty string when no film is passed" do
		movie_getter = MovieGetter.new
		expect(movie_getter.get_movie("")).to eq("")
	end
end


# ascii_movies = AsciiMovies.new(MovieGetter.new, RatingPrinter.new)
