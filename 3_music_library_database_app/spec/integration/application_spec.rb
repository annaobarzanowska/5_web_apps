require "spec_helper"
require "rack/test"
require_relative '../../app'

describe Application do
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }

  context "GET /albums" do
    it "returns the list of albums" do
      response = get('/albums')
      expected_response = 'Doolittle, Surfer Rosa, Waterloo, Super Trouper, Bossanova, Lover, Folklore, I Put a Spell on You, Baltimore, Here Comes the Sun, Fodder on My Wings, Ring Ring'
      
      expect(response.status).to eq 200
      expect(response.body).to eq expected_response
    end
  end

  context "GET /album/:id" do
    it "returns the album with id 1" do
        response = get('/album/1')

        expect(response.status).to eq 200
        expect(response.body).to include '<h1>Doolittle</h1>'
        expect(response.body).to include '<p> Release year: 1988   Artist: Pixies </p>'

    end
  end

  context "POST /albums" do
    it "creates an album named Voyage, release year 2022 and artist id 2" do
        response = post('/albums', title: 'Voyage', release_year: '2022', artist_id: '2')
        expect(response.status).to eq 200

        response_get = get('/albums')
        expect(response_get.status).to eq 200
        expect(response_get.body).to include 'Voyage'
    end
  end

  context "GET /artists" do
    xit "returns all the artists" do
        response = get('/artists')

        expect(response.status).to eq 200
        expect(response.body).to eq "Pixies, ABBA, Taylor Swift, Nina Simone, Kiasmos"
    end
    
  end
  

  context "POST /artists" do
  it 'adds a new artist and genre' do
    response = post('/artists', name:'Wild nothing', genre: 'Indie')
    response_get = get('/artists')


    expect(response.status).to eq(200)
    expect(response_get.body).to include('Wild nothing')
    end
  end
end


# # Request:
# POST /artists

# # With body parameters:
# name=Wild nothing
# genre=Indie

# # Expected response (200 OK)
# (No content)

# # Then subsequent request:
# GET /artists

# # Expected response (200 OK)
# Pixies, ABBA, Taylor Swift, Nina Simone, Wild nothing