class Player
	# attr_accessor :name, :board

	# def has_board?
	# 	!@board.nil?
	# end

	# def receive_shot(coordinate)
	# 	board.shoot_at(coordinate)
	# end

  def initialize(name: 'Default Name')
    @name = name
  end

  attr_reader :name

end