require_relative ('ascii_movies')
ascii_movies = AsciiMovies.new
input = 'spec/movies_input.txt'
output = 'movies_result.txt'
ascii_movies.console_print_ratings(input, output, "ascii")