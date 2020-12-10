class MovieService
  def self.top_rated
    top_movies = []
    page_num = 0
    2.times do
      page_num += 1
      response = conn.get('/3/movie/top_rated') do |req|
        req.params[:page] = page_num
      end
      top_movie_data = JSON.parse(response.body, symbolize_names: true)
      top_movies << top_movie_data[:results]
    end
    top_movies.flatten
  end

  def self.search(search_word)
    movie_results = []
    page_num = 0
    2.times do
      page_num += 1
      response = conn.get('/3/search/movie') do |req|
        req.params[:query] = search_word
        req.params[:page] = page_num
      end
      search_movie_data = JSON.parse(response.body, symbolize_names: true)
      movie_results << search_movie_data[:results]
    end
    movie_results.flatten
  end

  def self.movie_details(movie_id)
    to_json("/3/movie/#{movie_id}")
  end

  def self.reviews(movie_id)
    review_data = to_json("/3/movie/#{movie_id}/reviews")
    review_data[:results]
  end

  def self.credits(movie_id)
    credits_data = to_json("/3/movie/#{movie_id}/credits")
    credits_data[:cast]
  end

  def self.now_playing
    now_playing = to_json("/3/movie/now_playing")
    now_playing[:results]
  end

  private

  def self.conn
    Faraday.new(url: 'https://api.themoviedb.org') do |f|
      f.params['api_key'] = ENV['MOVIE_API_KEY']
    end
  end

  def self.to_json(path, params = {})
    response = conn.get(path) do |f|
      f.params = params
      f.params[:api_key] = ENV['MOVIE_API_KEY']
    end
    JSON.parse(response.body, symbolize_names: true)
  end
end
