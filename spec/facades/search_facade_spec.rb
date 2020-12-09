require 'rails_helper'

describe 'Search Facade' do
  it 'returns a list of movies for a given title', :vcr do
    search = "happy"

    movies = SearchFacade.fetch_movie_data(search)

    expect(movies).to be_an(Array)
    expect(movies.first).to be_a(MovieObj)
    expect(movies.first.title).to be_a(String)
    # expect(movies.first.title).to eq('Crash')
  end
end
