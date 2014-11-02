require 'sinatra/base'

class Battleships < Sinatra::Base

  require_relative './player'
  require_relative './game'

  set :views, Proc.new { File.join(root, "..", "views") }
  set :public_dir, Proc.new { File.join(root, "..", "public") }
  enable :sessions
  GAME = Game.new

  get '/' do
    # puts GAME.inspect
    @name = session[:me]
    erb :index
  end

  post '/register' do
    puts session.inspect
    # name = params[:player_name]
    player = Player.new(name: params[:player_name])
    GAME.add_player player
    # GAME.add_player Player.new(name: params[:player_name])
    session[:me] = params[:player_name]
    session[:me_as_player_object] = player
    erb :index
  end

  get '/new_game' do
    erb :new_game
  end

  get '/board' do

    @cells = create_grid
    @cells = @cells.values.map{|cell| cell.content}.each_slice(10).to_a
    @cells[0][0] = 'Ship!'
    @cells[1][0] = 'Ship!'
    @cells[2][0] = 'Ship!'
    @cells[0][1] = 'Ship!'
    @cells[0][2] = 'Ship!'
    
    # @cells = (1..100).map { |cell| '~' }.each_slice(10).to_a
    # @cells[0][0] = 'S'
    # @cells[1][0] = 'A'
    # @cells[2][0] = 'D'
    # @cells[0][1] = 'O'
    # @cells[0][2] = 'X'
    
    erb :board
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end

class Cell
  def content
    '~'
  end
end

def create_grid
  grid = {}
  ("A".."J").to_a.each{|l| (1..10).to_a.each {|n| grid["#{l}#{n}"] = "~" }}
  grid
end





# grid = {}
# ("A".."J").to_a.each{|l| (1..10).to_a.each {|n| grid["#{l}#{n}"] = "~" }}
# grid.values.each_slice(10).to_a


# [31] pry(main)> class Cell
# [31] pry(main)*   def content
# [31] pry(main)*     "~"
# [31] pry(main)*   end  
# [31] pry(main)* end  
# => :content
# [32] pry(main)> grid = {}
# => {}
# [33] pry(main)> ("A".."J").to_a.each{|l| (1..10).to_a.each {|n| grid["#{l}#{n}"] = Cell.new } }
# => ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J"]
# [34] pry(main)> grid

# [35] pry(main)> grid.values
# [36] pry(main)> Cell.new.content
# => "~"
# [37] pry(main)> grid.values.map { |cell| cell.content }
# [40] pry(main)> grid.values.map { |cell| cell.content }.each_slice(10).to_a


