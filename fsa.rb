require './state'

class FSA
  attr_reader :state, :states
  def initialize initial_state, states
    @state = initial_state
    @states = states
  end

  def accepted? input
    update input
    @state.accepted?
  end

  def rejected? input
    update input
    @state.rejected?
  end

  def update input
    input.split("").each do |trigger|
      @state = @state.next_state trigger
    end
  end

  private :update
end