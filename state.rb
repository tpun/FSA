require 'set'

class State
  attr_reader :name, :entry_triggers, :exit_triggers, :next_state
  def initialize config
    @name = config[:name]
    @entry_triggers = config[:entry_triggers]
    @exit_triggers = config[:exit_triggers]
    @accepted = config[:accepted] || false
    @rejected = config[:rejected] || false
    @next_state = config[:next_state]

    # TODO: Raise if we don't get all info for setting the State up.
  end

  def entry? trigger
    @entry_triggers.empty? or @entry_triggers.include? trigger
  end

  def exit? trigger
    @exit_triggers.empty? or @exit_triggers.include? trigger
  end

  def next_state trigger
    return self if entry? trigger
    return @next_state if exit? trigger
    nil
  end

  def accepted?
    @accepted
  end

  def rejected?
    @rejected
  end
end