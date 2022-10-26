require 'spec_helper'
require 'rack/test'
require_relative '../../app'

describe Application do
    include Rack::Test::Methods
    let(:app) { Application.new }

    context "GET /hello" do
        xit "returns 'Hello Leo" do
            response = get('/hello?name=Leo')
            
            expect(response.status).to eq 200
            expect(response.body).to eq 'Hello Leo'
        end

        xit "return 'Hello Anna" do
            response = get('/hello?name=Anna')
            
            expect(response.status).to eq 200
            expect(response.body).to eq 'Hello Anna'    
        end

        # it 'contains a h1 title' do
        #     response = get('/hello')
        
        #     expect(response.body).to include('<h1>Hello!</h1>')
        # end
    end

    context "GET /names" do
        it "returns 'Julia, Mary, Karim'" do 
            response = get('/names?names=Julia, Mary, Karim')

            expect(response.status).to eq 200
            expect(response.body).to eq "Julia, Mary, Karim"
        end
    end

    context "POST /sort-names" do
        it "returns a string of names in alphabetical order" do
            response = post('/sort-names?names=Joe,Alice,Zoe,Julia,Kieran')

            expect(response.status).to eq 200
            expect(response.body).to eq "Alice,Joe,Julia,Kieran,Zoe"
        end
    end
end

# # Request:
# POST http://localhost:9292/sort-names

# # With body parameters:
# names=Joe,Alice,Zoe,Julia,Kieran

# # Expected response (sorted list of names):
# Alice,Joe,Julia,Kieran,Zoe