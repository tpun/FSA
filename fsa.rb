require './state'

class FSA
  attr_reader :state, :states
  def initialize initial_state, states
    @initial_state = initial_state
    @states = states
  end

  def accepted? input
    update(input).accepted?
  end

  def rejected? input
    update(input).rejected?
  end

  def update input
    final = @initial_state
    input.split("").each do |trigger|
      final = final.next_state trigger
    end
    final
  end

  private :update
end