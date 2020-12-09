class SearchFacade
  def self.fetch_movie_data(search_word)
    conn = Faraday.new(url: 'https://api.themoviedb.org') do |f|
      f.params['api_key'] = ENV['MOVIE_API_KEY']
    end

    @search_results = []
    page_num = 0
    2.times do
      page_num += 1

      response = conn.get('/3/search/movie') do |req|
        req.params[:query] = search_word
        req.params[:page] = page_num
      end

      movie_data = JSON.parse(response.body, symbolize_names: true)
      # @search_results = movie_data[:results].map do |movie|
      #   MovieObj.new(movie)
      # end
      movies = movie_data[:results].map do |movie|
        MovieObj.new(movie)
      end
      @search_results << movies
    end
    @search_results = @search_results.flatten
  end
end
