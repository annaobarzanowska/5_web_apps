require 'sinatra/base'
require 'sinatra/reloader'

class Application < Sinatra::Base
  # This allows the app code to refresh
  # without having to restart the server.
  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    return erb(:index)
  end

  get '/hello' do
    name = params[:name]

    return "Hello #{name}"

  end

  get '/names' do
    names = params[:names]

    return "#{names}"
  end

  post '/sort-names' do
    names = params[:names]

    return "#{names.split(',').sort.join(',')}"
  end
end