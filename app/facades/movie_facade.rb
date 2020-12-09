class MovieFacade
  def self.fetch_top_40_movie_data
    conn = Faraday.new(url: 'https://api.themoviedb.org') do |f|
      f.params['api_key'] = ENV['MOVIE_API_KEY']
    end

    @movies = []
    page_num = 0
    2.times do
      page_num += 1

      response = conn.get('/3/movie/top_rated') do |req|
        req.params[:page] = page_num
      end

      movie_data = JSON.parse(response.body, symbolize_names: true)
      movies = movie_data[:results].map do |movie|
        MovieObj.new(movie)
      end
      @movies << movies
    end
    @movies = @movies.flatten
  end
end
