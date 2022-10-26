require "spec_helper"
require "rack/test"
require_relative '../../app' 

def reset_albums_table
  seed_sql = File.read('spec/seeds/albums_seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
  connection.exec(seed_sql)
end
def reset_artists_table
  seed_sql = File.read('spec/seeds/artists_seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
  connection.exec(seed_sql)
end


describe Application do
  before(:each) do 
    reset_albums_table
    reset_artists_table
  end
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }

  context "GET /" do
    it "returns the html index" do
      response = get('/')

      expect(response.body).to include '<h1>Hello!</h1>'
    end
  end

  context "GET /albums" do
    it "returns the list of albums" do
      response = get('/albums')
            
      expect(response.status).to eq 200
      expect(response.body).to include 'Doolittle'
      expect(response.body).to include '1989'
      expect(response.body).to include 'Surfer Rosa'
      expect(response.body).to include '1988'
    end
  end

  context "GET /albums/:id" do
    it "returns the album with id 1" do
        response = get('/albums/1')

        expect(response.status).to eq 200
        expect(response.body).to include '<h1>Doolittle</h1>'
        expect(response.body).to include 'Release year: 1989'
        expect(response.body).to include 'Artist: Pixies'

    end
    it "returns the album with id 2" do
      response = get('/albums/2')

      expect(response.status).to eq 200
      expect(response.body).to include '<h1>Surfer Rosa</h1>'
      expect(response.body).to include 'Release year: 1988'
      expect(response.body).to include 'Artist: Pixies'
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
    it "returns all the artists" do
        response = get('/artists')

        expect(response.status).to eq 200
        expect(response.body).to eq "Pixies, ABBA, Taylor Swift, Nina Simone"
    end    
  end

  context "when user clicks on link" do
    it "exists as a page" do
      response = get('/albums')

      expect(response.status).to eq 200
      expect(response.body).to include '/albums/1'

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