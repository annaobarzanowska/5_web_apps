require 'sinatra/base'
require 'sinatra/reloader'

class Application < Sinatra::Base
  # This allows the app code to refresh
  # without having to restart the server.
  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    return "Hello!"
  end

  get '/posts' do
    name = params[:name]
    cohort_name = params[:cohort_name]

    return "Hello, #{name}, you are in the #{cohort_name} cohort"
  end

  post '/posts' do
    title = params[:title]

    return "Post was created with the title #{title}"
  end

  post '/hello' do
    name = params[:name] # The value is 'Alice'
  
    # Do something with `name`...
  
    return "Hello #{name}"
  end
end
