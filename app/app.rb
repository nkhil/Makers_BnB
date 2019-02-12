ENV['database'] ||= 'MakersBnB'
# require 'sinatra'
require 'sinatra/base'
require 'sinatra/flash'
require_relative './lib/space'


class MakersBnB < Sinatra::Base
  get '/' do
    @spaces = Space.all
    erb :index
  end

  get '/my-spaces' do
    @spaces = Space.all
    erb :my_spaces
  end

  get '/post-space' do
    erb :postspace
  end

  post '/post-space' do
    Space.create(
      space_name: params[:spacename],
      description: params[:description],
      price: params[:price]
    )
    redirect '/'
  end

  run! if app_file == $0
end
