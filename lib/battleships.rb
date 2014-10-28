require 'sinatra/base'

class Battleships < Sinatra::Base

  require_relative './player'
  require_relative './game'

  GAME = Game.new

  set :views, Proc.new { File.join(root, "..", "views") }

  enable :sessions

  get '/' do
    puts session.inspect
    @name = session[:me]
    erb :index
  end

  post '/register' do
    session[:me] = params[:player_name]
    erb :index
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
