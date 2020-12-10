require 'rails_helper'

describe MovieService do
  it 'top_rated' do
    movies = MovieService.top_rated

    expect(movies).to be_a(Array)

    movie_data = movies.first

    expect(movie_data).to have_key(:title)
    expect(movie_data[:title]).to be_a(String)
    expect(movie_data).to have_key(:vote_average)
    expect(movie_data[:vote_average]).to be_a(Float)
  end

  it 'search()' do
    movies = MovieService.search('happy')

    expect(movies).to be_a(Array)

    movie_data = movies.first

    expect(movie_data).to have_key(:title)
    expect(movie_data[:title]).to be_a(String)
    expect(movie_data).to have_key(:vote_average)
    expect(movie_data[:vote_average]).to be_a(Float)
  end

  it 'movie_details()' do
    movie = MovieService.movie_details(9614)

    expect(movie).to be_a(Hash)
    expect(movie[:title]).to be_a(String)
    expect(movie).to have_key(:vote_average)
    expect(movie[:vote_average]).to be_a(Float)
    expect(movie).to have_key(:overview)
    expect(movie[:overview]).to be_a(String)
    expect(movie).to have_key(:runtime)
    expect(movie[:runtime]).to be_a(Integer)
    expect(movie).to have_key(:genres)
    expect(movie[:genres]).to be_a(Array)
  end

  it 'reviews' do
    reviews = MovieService.reviews(9614)

    expect(reviews).to be_a(Array)
    expect(reviews.first).to be_a(Hash)
    expect(reviews.first).to have_key(:author)
    expect(reviews.first[:author]).to be_a(String)
    expect(reviews.first).to have_key(:content)
    expect(reviews.first[:content]).to be_a(String)
  end

  it 'credits' do
    cast = MovieService.credits(9614)

    expect(cast).to be_a(Array)
    expect(cast.first).to be_a(Hash)
    expect(cast.first).to have_key(:name)
    expect(cast.first[:name]).to be_a(String)
    expect(cast.first).to have_key(:character)
    expect(cast.first[:character]).to be_a(String)
  end
end
